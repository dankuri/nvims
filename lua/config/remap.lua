vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "move highlighted block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "move highlighted block up" })

-- best in class
vim.keymap.set("i", "jk", "<Esc>", { desc = "escape from insert" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "concat down without cursor moving" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "halfpage down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "halfpage up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "goto next search item (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "goto prev search item (centered)" })

vim.keymap.set("n", "M", ":Man<CR>", { desc = "open man page" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without copying" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy in sys clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy in sys clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]], { desc = "delete without copying" })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "substitute word" })
vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { desc = "make file executable" })

vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "toggle wrap" })
vim.keymap.set("n", "<leader>tS", ":set spell!<CR>", { desc = "toggle spell" })

-- tabs
vim.keymap.set("n", "H", ":tabp<CR>", { desc = "prev tab", silent = true })
vim.keymap.set("n", "L", ":tabn<CR>", { desc = "next tab", silent = true })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "new tab", silent = true })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "close tab", silent = true })

-- move between panes & tmux splits with Alt + direction
vim.keymap.set({ "n", "t" }, "<M-h>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "cursor move left" })
vim.keymap.set({ "n", "t" }, "<M-l>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "cursor move right" })
vim.keymap.set({ "n", "t" }, "<M-k>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "cursor move up" })
vim.keymap.set({ "n", "t" }, "<M-j>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "cursor move down" })
vim.keymap.set({ "n", "t" }, "<M-\\>", function()
	require("smart-splits").move_cursor_previous()
end, { desc = "cursor move previous" })
