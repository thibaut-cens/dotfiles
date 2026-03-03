return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
	opts = {
		suggestion = {
			enabled = false,
		},
		panel = { enabled = true },
		-- filetypes = {
		-- 	markdown = true,
		-- 	help = true,
		-- },
	},
}
