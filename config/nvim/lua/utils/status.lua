local M = {}

function HasValue(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

--- @alias StatusEntryContent string[]|nil The highlight group name (e.g., "DiagnosticError")

--- @class Status
--- @field entries table<string, table<string, StatusEntryContent>>
local Status = {}
Status.__index = Status

function Status.new()
	local self = setmetatable({}, Status)
	self.entries = {} -- Stores path = action
	return self
end

--- Adds or updates a status entry for a specific path.
--- @param path string The absolute or relative file path.
--- @param status string The status category (e.g., "cut", "git_modified").
--- @param content StatusEntryContent The visual metadata for this status.
function Status:set(path, status, content)
	if self.entries[path] == nil then
		self.entries[path] = {}
	end
	self.entries[path][status] = content
	local action_str = content ~= nil and "Applied" or "Cleared"
	print(string.format("%s: %s status %s", path, action_str, status))
end

--- @param path string
--- @param status_match string List of statuses to clear. If empty match all statuses
function Status:clear(path, status_match)
	for kpath, v in pairs(self.entries) do
		if path == nil or kpath == path then
			for kstatus, _ in pairs(v) do
				if status_match == nil or string.match(kstatus, status_match) then
					self:set(kpath, kstatus, nil)
				end
			end
		end
	end
end

---@param path string
---@return table<string, StatusEntryContent>
function Status:get(path)
	return self.entries[path] or {}
end

function Status:reverse()
	local ret = {}
	for path, v in pairs(self.entries) do
		for status, _ in pairs(v) do
			if ret[status] == nil then
				ret[status] = {}
			end

			table.insert(ret[status], path)
		end
	end
	return ret
end

M.Status = Status

return M
