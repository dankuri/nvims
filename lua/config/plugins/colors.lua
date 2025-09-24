return {
	{
		"Mofiqul/dracula.nvim",
		config = function()
			require("dracula").setup({
				show_end_of_buffer = true,
				transparent_bg = true,
			})
			-- vim.cmd.colorscheme("dracula")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				float = {
					solid = false,
					transparent = false,
				},
				transparent_background = true,
				show_end_of_buffer = true,
				auto_integrations = true,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
