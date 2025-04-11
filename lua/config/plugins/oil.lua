return {
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				win_options = {
					signcolumn = "yes:2",
				},
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name, _)
						return name == ".."
					end,
				},
			})
			-- use trash-cli instead of macos builtin trash
			if vim.loop.os_uname().sysname == "Darwin" and vim.fn.exepath("trash") ~= "" then
				package.loaded["oil.adapters.trash"] = require("oil.adapters.trash.freedesktop")
			end
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			opts = {
				override_by_filename = {
					["go.mod"] = {
						icon = "󰟓",
						color = "#00ADD8",
						name = "GoModule",
					},
					["go.sum"] = {
						icon = "󰟓",
						color = "#00ADD8",
						name = "GoModuleChecksum",
					},
					["go.work"] = {
						icon = "󰟓",
						color = "#00ADD8",
						name = "GoWorkspace",
					},
				},
				override_by_extension = {
					["go"] = {
						icon = "󰟓",
						color = "#00ADD8",
						name = "Go",
					},
				},
			},
		},
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		opts = {},
	},
}
