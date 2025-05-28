return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
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

		-- allows to search for files (CTRL+Space to toggle all files) -> grep in only selected files
		local files_word = function()
			builtin.find_files({
				attach_mappings = function(prompt_bufnr, map)
					local actions = require("telescope.actions")
					local action_state = require("telescope.actions.state")

					map("i", "<c-space>", actions.toggle_all)

					actions.select_default:replace(function()
						local current_picker = action_state.get_current_picker(prompt_bufnr)
						local selections = current_picker:get_multi_selection()
						-- if no multi-selection, leverage current selection
						if vim.tbl_isempty(selections) then
							table.insert(selections, action_state.get_selected_entry())
						end
						local paths = vim.tbl_map(function(e)
							return e.path
						end, selections)
						actions.close(prompt_bufnr)
						builtin.live_grep({
							search_dirs = paths,
						})
					end)
					-- true: attach default mappings; false: don't attach default mappings
					return true
				end,
			})
		end

		vim.keymap.set("n", "<leader>fF", builtin.find_files, { desc = "find all files" })
		vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "find git files" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "find old files" })
		vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "find word" })
		vim.keymap.set("n", "<leader>fW", files_word, { desc = "find word in selected files" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "find buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "find diagnostics" })
		vim.keymap.set("n", "<leader>tt", builtin.resume, { desc = "telescope resume" })
		vim.keymap.set("n", "<leader>tp", builtin.pickers, { desc = "telescope pickers" })
		vim.keymap.set("n", "<leader>ts", builtin.lsp_document_symbols, { desc = "telescope document symbols" })
	end,
}
