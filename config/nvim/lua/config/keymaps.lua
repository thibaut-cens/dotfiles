-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use `vim.keymap.set` instead
local map = vim.keymap.set

-- Escape mapping
map({ "i", "x" }, "<A-;>", "<esc>", { desc = "Return to normal mode", remap = true })

-- Move cursor
-- =============================================================================
map({ "i", "n", "v" }, "<A-h>", "<Left>", { desc = "Move cursor left in insert mode", remap = true })
map({ "i", "n", "v" }, "<A-j>", "<Down>", { desc = "Move cursor down in insert mode", remap = true })
map({ "i", "n", "v" }, "<A-k>", "<Up>", { desc = "Move cursor up in insert mode", remap = true })
map({ "i", "n", "v" }, "<A-l>", "<Right>", { desc = "Move cursor right in insert mode", remap = true })
----------
map({ "i", "n", "v" }, "<S-A-l>", "<S-Right>", { remap = true })
map({ "i", "n", "v" }, "<S-A-h>", "<S-Left>", { remap = true })
----------
vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
	require("flash").treesitter({
		actions = {
			["<A-o>"] = "next",
			["<A-i>"] = "prev",
		},
	})
end, { desc = "Treesitter incremental selection" })

-- Move Lines
-- =============================================================================
map("n", "<S-A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<S-A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
----------
map("i", "<S-A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<S-A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
----------
map("v", "<S-A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<S-A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
