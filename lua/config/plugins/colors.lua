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
				transparent_background = true,
				show_end_of_buffer = true,
				integrations = {
					blink_cmp = true,
					harpoon = true,
					grug_far = true,
					mason = true,
					neotest = true,
					dadbod_ui = true,
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
