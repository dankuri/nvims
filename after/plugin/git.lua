require("gitsigns").setup({
	on_attach = function(bufnr)
		vim.keymap.set("n", "[c", require("gitsigns").prev_hunk, { buffer = bufnr, desc = "prev hunk" })
		vim.keymap.set("n", "]c", require("gitsigns").next_hunk, { buffer = bufnr, desc = "next hunk" })
		vim.keymap.set(
			"n",
			"<leader>gp",
			require("gitsigns").preview_hunk_inline,
			{ buffer = bufnr, desc = "preview hunk" }
		)
		vim.keymap.set("n", "<leader>gb", require("gitsigns").blame_line, { buffer = bufnr, desc = "blame line" })
	end,
})
