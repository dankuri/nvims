return {
	{
		"Mofiqul/dracula.nvim",
		config = function()
			require("dracula").setup({
				show_end_of_buffer = true,
				transparent_bg = true,
			})
			vim.cmd.colorscheme("dracula")
		end,
	},
}
