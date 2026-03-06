-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use `vim.keymap.set` instead
local map = vim.keymap.set

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Move Cursor                                                                 │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

---------- Remap A+<key> to arrow keys ----------
map({ "n", "i", "v", "c" }, "<A-h>", "<Left>", { desc = "Move cursor left in insert mode", remap = true })
map({ "n", "i", "v", "c" }, "<A-j>", "<Down>", { desc = "Move cursor down in insert mode", remap = true })
map({ "n", "i", "v", "c" }, "<A-k>", "<Up>", { desc = "Move cursor up in insert mode", remap = true })
map({ "n", "i", "v", "c" }, "<A-l>", "<Right>", { desc = "Move cursor right in insert mode", remap = true })

---------- Remap S+A+<key> to arrow keys ----------
map({ "n", "i", "v" }, "<S-A-l>", "<S-Right>", { remap = true })
map({ "n", "i", "v" }, "<S-A-h>", "<S-Left>", { remap = true })
map({ "n", "i", "v" }, "<S-A-k>", "<S-Up>", { remap = true })
map({ "n", "i", "v" }, "<S-A-j>", "<S-Down>", { remap = true })

---------- Move cursor by paragraph ----------
map({ "n", "i", "v" }, "<S-Up>", "{", { remap = true })
map({ "n", "i", "v" }, "<S-Down>", "}", { remap = true })

---------- Move cursor by word ----------
map({ "v", "x" }, "<S-h>", "W", { remap = true })
map({ "v", "x" }, "<S-l>", "B", { remap = true })

---------- Semantic selection ----------
vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
	require("flash").treesitter({
		actions = {
			["<A-o>"] = "next",
			["<A-i>"] = "prev",
		},
	})
end, { desc = "Treesitter incremental selection" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Move Lines                                                                  │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

---------- Move selected lines up and down ----------
map("v", "<S-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<S-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Utils                                                                       │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

---------- Open Snacks terminal ----------
map({ "n", "i", "v" }, "<C-/>", function()
	win, created = Snacks.terminal.get()
	local is_focused = win and win:valid() and win == vim.api.nvim_get_current_win()

	if created then
		return
	elseif is_focused then
		win:hide()
	else
		win:show()
		win:focus()
	end
end)

---------- Map mode escape ----------
map({ "i", "x" }, "<A-;>", "<esc>", { desc = "Return to normal mode", remap = true })
