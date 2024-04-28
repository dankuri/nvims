local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"javascript",
		"typescript",
		"go",
		"elixir",
		"rust",
		"html",
		"css",
	},
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})
