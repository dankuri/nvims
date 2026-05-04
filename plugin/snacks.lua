vim.pack.add({
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/todo-comments.nvim",
})
require("snacks").setup({
	bigfile = { enabled = true },
	image = { enabled = true },
	indent = {
		enabled = true,
		animate = { enabled = false },
	},
	input = { enabled = true },
	lazygit = {
		enabled = true,
		config = {
			gui = { nerdFontsVersion = "" },
		},
	},
	notifier = { enabled = true },
	picker = {
		enabled = true,
		matcher = {
			frecency = true,
		},
	},
	quickfile = { enabled = true },
	scratch = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})
require("todo-comments").setup({})

vim.keymap.set("n", "<leader><leader>", function() Snacks.picker.smart() end, { desc = "smart find" })
vim.keymap.set("n", "<leader>rr", function() Snacks.picker.resume() end, { desc = "resume picker" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "find buffers" })
vim.keymap.set("n", "<leader>fF", function() Snacks.picker.files() end, { desc = "find all files" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.git_files() end, { desc = "find git files" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "find recent files" })
vim.keymap.set("n", "<leader>fw", function() Snacks.picker.grep() end, { desc = "find word" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "find help" })
vim.keymap.set("n", "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "find diagnostics" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.pickers() end, { desc = "find pickers" })
vim.keymap.set("n", "<leader>fs", function() Snacks.picker.lsp_symbols() end, { desc = "find symbols" })
vim.keymap.set("n", "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "find all symbols" })
vim.keymap.set("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "find notifications" })
vim.keymap.set("n", "<leader>ft", function() Snacks.picker.todo_comments() end, { desc = "find todos" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit() end, { desc = "LazyGit" })
vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "toggle scratch" })
vim.keymap.set("n", "]r", function() Snacks.words.jump(1, true) end, { desc = "next word reference" })
vim.keymap.set("n", "[r", function() Snacks.words.jump(-1, true) end, { desc = "prev word reference" })
