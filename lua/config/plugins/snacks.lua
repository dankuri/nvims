return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{
						icon = " ",
						key = "n",
						desc = "New File",
						action = ":ene | startinsert",
					},
					{
						icon = " ",
						key = "e",
						desc = "Explore Files",
						action = ":e .",
					},
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.dashboard.pick('files')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "w",
						desc = "Find Word",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = "󰊢 ",
						key = "g",
						desc = "Git",
						action = ":0G",
					},
					{
						icon = "󱡀 ",
						key = "h",
						desc = "Harpoon",
						action = ":HarpoonMenu",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{
						icon = " ",
						key = "m",
						desc = "Mason",
						action = ":Mason",
					},
					{
						icon = " ",
						key = "q",
						desc = "Quit",
						action = ":qa",
					},
				},
				header = [[
⠀⣞⢽⢪⢣⢣⢣⢫NO BUFFERS?⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀ 
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀         ]],
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
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
		statuscolumn = {
			enabled = true,
		},
	},
	keys = {
		{ "<leader><leader>", function() Snacks.picker.smart() end, desc = "smart find" },
		{ "<leader>rr", function() Snacks.picker.resume() end, desc = "resume picker" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "find buffers" },
		{ "<leader>fF", function() Snacks.picker.files() end, desc = "find all files" },
		{ "<leader>ff", function() Snacks.picker.git_files() end, desc = "find git files" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "find recent files" },
		{ "<leader>fw", function() Snacks.picker.grep() end, desc = "find word" },
		{ "<leader>fh", function() Snacks.picker.help() end, desc = "find help" },
		{ "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "find diagnostics" },
		{ "<leader>fp", function() Snacks.picker.pickers() end, desc = "find pickers" },
		{ "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "find symbols" },
		{ "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "find all symbols" },
		{ "<leader>fn", function() Snacks.picker.notifications() end, desc = "find notifications" },
		{ "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "find todos" },
		{ "<leader>gl", function() Snacks.lazygit() end, desc = "LazyGit" },
		{ "<leader>.", function() Snacks.scratch() end, desc = "toggle scratch" },
	},
}
