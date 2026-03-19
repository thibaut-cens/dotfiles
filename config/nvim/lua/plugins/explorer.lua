vim.api.nvim_set_hl(0, "SnacksClipboardAction", {
	fg = "#ffffff",
	bold = true,
})

local dump = require("utils.dump").dump
local StatusClass = require("utils.status").Status

--- @class Status Status
local Status = StatusClass.new()

--- @param item snacks.picker.Item
local function path_move_callback(item)
	if item.dir then
		print(string.format("Change CWD for '%s'", item._path))
		vim.api.nvim_set_current_dir(item._path)
	end
end

---@param picker snacks.Picker
---@param status string
---@param config string[]
local function clip_callback(picker, status, config)
	if not picker then
		return
	end

	local __status = "clip-" .. status

	if vim.fn.mode():find("^[vV]") then
		picker.list:select()
	end

	local paths = picker:selected({ fallback = true })
	for _, item in ipairs(paths) do
		local path = Snacks.picker.util.path(item)
		if path ~= nil then
			local previously_defined = Status:get(path)[__status] ~= nil

			Status:clear(path, "^clip-.*$")

			if not previously_defined then
				Status:set(path, __status, config)
			end
		end
	end

	picker.list:set_selected() -- clear selection

	picker:refresh()
end

-- 2. In your snacks.nvim config:
return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			sources = {
				explorer = {
					---@type snacks.picker.format
					format = function(item, picker)
						-- 1. Get the default "file" format (returns a list of {text, hl} tables)
						local ret = Snacks.picker.format.file(item, picker)

						local statuses = Status:get(item._path)

						if statuses then
							local chunk = {
								virt_text_pos = "right_align",
								hl_mode = "combine",
								col = 0,
								virt_text = {},
							}

							for _, v in pairs(statuses) do
								table.insert(chunk["virt_text"], v)
							end

							table.insert(ret, chunk)

							-- -- Apply the background highlight to every chunk in the line
							-- for _, chunk in ipairs(ret) do
							-- 	-- chunk[1] is the text, chunk[2] is the highlight group
							-- 	-- We wrap the existing highlight to keep the foreground color
							-- 	-- but add our background (Note: requires a clever theme or 'combine')
							-- 	chunk[2] = hl_group
							-- end
						end

						return ret
					end,

					actions = {
						explorer_up_and_callback = function(picker)
							-- Call the default 'up' action
							require("snacks.explorer.actions").actions.explorer_up(picker)

							-- Run your logic
							path_move_callback(picker:cwd())
						end,

						explorer_focus_and_callback = function(picker, item)
							-- Call the default 'focus' action
							require("snacks.explorer.actions").actions.explorer_focus(picker)

							path_move_callback(item)
						end,

						explorer_pick_buffer_and_open = function(picker, item)
							local snacks = require("snacks")
							local win = snacks.picker.util.pick_win()
							if win == nil then
								Snacks.notify.warn("No window selected")
								return
							else
								vim.api.nvim_win_call(win, function()
									vim.cmd("edit " .. item._path)
								end)
							end
						end,

						explorer_cut = function(picker)
							clip_callback(picker, "cut", { "", "SnacksClipboardAction" })
						end,

						explorer_yank = function(picker)
							clip_callback(picker, "yank", { "", "SnacksClipboardAction" })
						end,

						--- @param item snacks.picker.Item
						--- @param picker snacks.Picker
						explorer_paste = function(picker)
							local dir = picker:dir()

							local dict = Status:reverse()
							if dict["clip-yank"] then
								Snacks.picker.util.copy(dict["clip-yank"], dir)
							end

							for _, path in ipairs(dict["clip-cut"]) do
								local new_path = vim.fs.joinpath(dir, vim.fs.basename(path))
								print(string.format("Move from %s to %s", path, new_path))
								Snacks.rename.rename_file({ from = path, to = new_path })
							end

							Status:clear()
							picker:update()
						end,
					},
					win = {
						list = {
							keys = {
								["<BS>"] = "explorer_up_and_callback",
								["."] = "explorer_focus_and_callback",
								["x"] = "explorer_cut",
								["p"] = "explorer_paste",
								["L"] = "explorer_pick_buffer_and_open",
							},
						},
					},
				},
			},
		},
	},
}
