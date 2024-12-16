return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					vim.keymap.set("n", "[g", function()
						require("gitsigns").nav_hunk("prev")
					end, { buffer = bufnr, desc = "prev git hunk" })
					vim.keymap.set("n", "]g", function()
						require("gitsigns").nav_hunk("next")
					end, { buffer = bufnr, desc = "next git hunk" })
					vim.keymap.set(
						"n",
						"<leader>gp",
						require("gitsigns").preview_hunk_inline,
						{ buffer = bufnr, desc = "preview hunk" }
					)
					vim.keymap.set(
						"n",
						"<leader>gr",
						require("gitsigns").reset_hunk,
						{ buffer = bufnr, desc = "reset hunk" }
					)
					vim.keymap.set(
						"n",
						"<leader>gb",
						require("gitsigns").blame_line,
						{ buffer = bufnr, desc = "blame line" }
					)
				end,
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
		cmd = "LazyGit",
	},
}
