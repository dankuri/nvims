return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			telescope.load_extension("ui-select")
			telescope.load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fF", builtin.find_files, { desc = "find all files" })
			vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "find git files" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "find old files" })
			vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "find word" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "find buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "find diagnostics" })
			vim.keymap.set("n", "<leader>tt", builtin.resume, { desc = "telescope resume" })
			vim.keymap.set("n", "<leader>tp", builtin.pickers, { desc = "telescope pickers" })
			vim.keymap.set("n", "<leader>ts", builtin.lsp_document_symbols, { desc = "telescope document symbols" })
			vim.keymap.set("n", "<leader>ty", ":Telescope yaml_schema<CR>", { desc = "yaml schema selector" })
		end,
	},
}
