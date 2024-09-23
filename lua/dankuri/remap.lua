vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Oil, { desc = "file explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "move highlighted block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "move highlighted block up" })

-- best in class
vim.keymap.set("i", "jj", "<Esc>", { desc = "escape from insert" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "concat down without cursor moving" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "halfpage down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "halfpage up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "goto next search item (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "goto prev search item (centered)" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without copying" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy in sys clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy in sys clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]], { desc = "delete without copying" })

vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "substitute word" })
vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { desc = "make file executable" })

vim.keymap.set("n", "<leader>tf", ":ToggleFormat<CR>", { desc = "toggle format" })
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "toggle wrap" })
vim.keymap.set("n", "<leader>tS", ":set spell!<CR>", { desc = "toggle spell" })
vim.keymap.set("n", "<leader>gl", ":LazyGit<CR>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>ie", ":GoIfErr<CR>", { desc = "Go If Error" })

vim.keymap.set({ "n", "t" }, "<M-h>", ":NavigatorLeft<CR>", { silent = true })
vim.keymap.set({ "n", "t" }, "<M-l>", ":NavigatorRight<CR>", { silent = true })
vim.keymap.set({ "n", "t" }, "<M-k>", ":NavigatorUp<CR>", { silent = true })
vim.keymap.set({ "n", "t" }, "<M-j>", ":NavigatorDown<CR>", { silent = true })
