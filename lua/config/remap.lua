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
vim.keymap.set("n", "<leader>tl", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle inlay hints" })
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "toggle wrap" })
vim.keymap.set("n", "<leader>tS", ":set spell!<CR>", { desc = "toggle spell" })

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
vim.keymap.set({ "n", "t" }, "<M-r>", function()
	if vim.g.smart_resize_mode then
		require("smart-splits.resize-mode").end_resize_mode()
	else
		require("smart-splits.resize-mode").start_resize_mode()
	end
end, { desc = "toggle resize mode" })
