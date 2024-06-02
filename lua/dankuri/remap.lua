vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Oil, { desc = "explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move highlighted block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move highlighted block up" })

-- best in class
vim.keymap.set("i", "jj", "<Esc>", { desc = "escape from insert" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "concat down without cursor moving" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "halfpage down centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "halfpage up centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "dont remember bruh" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "dont remember bruh" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without copying" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy in sys clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy in sys clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without copying" })

vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "substitute word" })
vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { desc = "make file executable" })

vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "zen mode" })

vim.keymap.set("n", "<leader>tf", ":ToggleFormat<CR>", { desc = "toggle format" })
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "toggle wrap" })
vim.keymap.set("n", "<leader>gl", ":LazyGit<CR>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>ie", ":GoIfErr<CR>", { desc = "Go If Error" })

vim.keymap.set({ "n", "t", "i", "v" }, "<M-h>", ":NavigatorLeft<CR>")
vim.keymap.set({ "n", "t", "i", "v" }, "<M-l>", ":NavigatorRight<CR>")
vim.keymap.set({ "n", "t", "i", "v" }, "<M-k>", ":NavigatorUp<CR>")
vim.keymap.set({ "n", "t", "i", "v" }, "<M-j>", ":NavigatorDown<CR>")
