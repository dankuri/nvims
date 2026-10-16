vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
	enabled = function(root_dir) return not vim.uv.fs_stat(root_dir .. "/.luarc.json") end,
})
