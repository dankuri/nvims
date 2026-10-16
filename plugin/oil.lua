vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/refractalize/oil-git-status.nvim",
})
require("oil").setup({
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	watch_for_changes = true,
	win_options = { signcolumn = "yes:2" },
	view_options = {
		show_hidden = true,
		natural_order = true,
		is_always_hidden = function(name, _) return name == ".." end,
	},
})
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "file explorer", silent = true })
-- use trash-cli instead of macos builtin trash
if vim.uv.os_uname().sysname == "Darwin" and vim.fn.exepath("trash") ~= "" then
	package.loaded["oil.adapters.trash"] = require("oil.adapters.trash.freedesktop")
end
require("oil-git-status").setup({})
