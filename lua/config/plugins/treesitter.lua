return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				auto_install = true,
				sync_install = false,
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"go",
					"gomod",
					"gosum",
					"gowork",
					"elixir",
					"rust",
					"html",
					"css",
				},
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = { query = "@function.outer", desc = "function" },
							["if"] = { query = "@function.inner", desc = "function" },
							["ic"] = { query = "@class.inner", desc = "class" },
							["ac"] = { query = "@class.outer", desc = "class" },
							["aa"] = { query = "@parameter.outer", desc = "argument" },
							["ia"] = { query = "@parameter.inner", desc = "argument" },
							["ai"] = { query = "@conditional.outer", desc = "conditional" },
							["ii"] = { query = "@conditional.inner", desc = "conditional" },
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = { query = "@function.outer", desc = "next function" },
							["]c"] = { query = "@class.outer", desc = "next class" },
							["]a"] = { query = "@parameter.outer", desc = "next argument" },
							["]i"] = { query = "@conditional.outer", desc = "next conditional" },
							["]l"] = { query = "@loop.outer", desc = "next loop" },
						},
						goto_previous_start = {
							["[f"] = { query = "@function.outer", desc = "prev function" },
							["[c"] = { query = "@class.outer", desc = "prev class" },
							["[a"] = { query = "@parameter.outer", desc = "prev argument" },
							["[i"] = { query = "@conditional.outer", desc = "prev conditional" },
							["[l"] = { query = "@loop.outer", desc = "prev loop" },
						},
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufEnter",
	},
}
