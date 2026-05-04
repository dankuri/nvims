vim.pack.add({ "https://github.com/hat0uma/csvview.nvim" })
require("csvview").setup({
	parser = { comments = { "#", "//" } },
})
vim.keymap.set("n", "<leader>cv", ":CsvViewToggle header_lnum=1<CR>", { silent = true, desc = "csv view" })
