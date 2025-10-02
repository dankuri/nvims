return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})

		vim.api.nvim_create_user_command("HarpoonMenu", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {})

		vim.keymap.set("n", "<leader>m", vim.cmd.HarpoonMenu, { desc = "HARPOON: menu" })
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "HARPOON: add file" })
		vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end, { desc = "HARPOON: open 1st file" })
		vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end, { desc = "HARPOON: open 2nd file" })
		vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end, { desc = "HARPOON: open 3rd file" })
		vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end, { desc = "HARPOON: open 4th file" })
	end,
}
