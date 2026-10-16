vim.pack.add({
	"https://github.com/tpope/vim-rhubarb",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/shumphrey/fugitive-gitlab.vim",
	"https://github.com/lewis6991/gitsigns.nvim",
})
local gitsigns = require("gitsigns")
gitsigns.setup({
	numhl = true,
	on_attach = function(bufnr)
		local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { desc = "GIT: " .. desc, buffer = bufnr }) end

		map("n", "[g", function() gitsigns.nav_hunk("prev") end, "prev hunk")
		map("n", "]g", function() gitsigns.nav_hunk("next") end, "next hunk")
		map("n", "<leader>gp", gitsigns.preview_hunk_inline, "preview hunk")
		map("n", "<leader>gR", gitsigns.reset_hunk, "reset hunk")
		map("n", "<leader>gb", gitsigns.blame_line, "blame line")
		map("n", "<leader>gB", gitsigns.blame, "blame side")
	end,
})
