return {
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb",
			"shumphrey/fugitive-gitlab.vim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		opts = {
			numhl = true,
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { desc = "GIT: " .. desc, buffer = bufnr })
				end

				map("n", "[g", function() gitsigns.nav_hunk("prev") end, "prev hunk")
				map("n", "]g", function() gitsigns.nav_hunk("next") end, "next hunk")
				map("n", "<leader>gp", gitsigns.preview_hunk_inline, "preview hunk")
				map("n", "<leader>gR", gitsigns.reset_hunk, "reset hunk")
				map("n", "<leader>gb", gitsigns.blame_line, "blame line")
				map("n", "<leader>gB", gitsigns.blame, "blame side")
			end,
		},
	},
}
