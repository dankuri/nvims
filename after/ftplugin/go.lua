vim.keymap.set("n", "<localleader>ie", ":GoIfErr<CR>", { silent = true, desc = "GO: if err" })
vim.keymap.set("n", "<localleader>g", ":GoGenerate<CR>", { silent = true, desc = "GO: generate" })
vim.keymap.set("n", "<localleader>at", ":GoAddTag ", { desc = "GO: add tag" })
