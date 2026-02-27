local M = {}
function M.dump(o, indent)
	return __dump(o, indent or 2, 1)
end

-- o: The object to dump (table, string, number, etc.)
-- indent: Likely intended as a boolean or number to toggle pretty-printing
-- level: The current depth of recursion (used to calculate spacing)
function __dump(o, indent, level)
	local function __is_associative(t)
		if type(t) ~= "table" then
			return false
		end

		local count = 0
		for k, _ in pairs(t) do
			-- If any key is not a number, it's associative
			if type(k) ~= "number" then
				return true
			end
			count = count + 1
		end

		-- If the number of elements is greater than the length (#t),
		-- it means there are non-sequential integer keys or "holes".
		return count ~= #t
	end

	local function __indent(s, i, l, nl)
		nl = nl or "\n"
		if i <= 0 then
			return s
		end
		local ret = string.rep(" ", i * l) .. s .. nl
		return ret
	end

	-- Check if the current item is a table; if not, we just return its string value
	if type(o) == "table" then
		-- START TABLE STRING
		-- Note: 'indent > 0 and "\n" or " "' is a Lua ternary.
		-- If indent is enabled, it starts a new line.
		local is_associative = __is_associative(o)
		local surround = is_associative and "{}" or "[]"
		local s = string.sub(surround, 1, 1) .. (indent > 0 and "\n" or "")

		-- ITERATE OVER TABLE
		for k, v in pairs(o) do
			-- If the key is a string (associative), wrap it in quotes for the dump
			local __s = ""
			if is_associative then
				__s = __s .. '"' .. k .. '": '
			end

			__s = __s .. __dump(v, indent, level + 1) .. ","
			s = s .. __indent(__s, indent, level)
		end

		-- CLOSE TABLE STRING
		return s .. __indent(string.sub(surround, 2, 2), indent, level - 1, "")
	elseif o ~= nil then
		-- BASE CASE
		-- If 'o' is a number, string, or boolean, just return it as a string
		return '"' .. tostring(o) .. '"'
	end
end

return M
