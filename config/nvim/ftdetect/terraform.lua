-- .config/nvim/ftdetect/terraform.lua

vim.filetype.add({
	extension = {
		tf = "terraform",
		tfvars = "terraform",
		hcl = "hcl",
	},
})
