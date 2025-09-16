return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
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
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀         
					]],
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
		{ "<leader><leader>", ":lua Snacks.picker.smart()<CR>", desc = "smart find", silent = true },
		{ "<leader>rr", ":lua Snacks.picker.resume()<CR>", desc = "resume picker", silent = true },
		{ "<leader>fb", ":lua Snacks.picker.buffers()<CR>", desc = "find buffers", silent = true },
		{ "<leader>fF", ":lua Snacks.picker.files()<CR>", desc = "find all files", silent = true },
		{ "<leader>ff", ":lua Snacks.picker.git_files()<CR>", desc = "find git files", silent = true },
		{ "<leader>fr", ":lua Snacks.picker.recent()<CR>", desc = "find recent files", silent = true },
		{ "<leader>fw", ":lua Snacks.picker.grep()<CR>", desc = "find word", silent = true },
		{ "<leader>fh", ":lua Snacks.picker.help()<CR>", desc = "find help", silent = true },
		{ "<leader>fd", ":lua Snacks.picker.diagnostics()<CR>", desc = "find diagnostics", silent = true },
		{ "<leader>fp", ":lua Snacks.picker.pickers()<CR>", desc = "find pickers", silent = true },
		{ "<leader>fs", ":lua Snacks.picker.lsp_symbols()<CR>", desc = "find symbols", silent = true },
		{ "<leader>fS", ":lua Snacks.picker.lsp_workspace_symbols()<CR>", desc = "find all symbols", silent = true },
		{ "<leader>fn", ":lua Snacks.picker.notifications()<CR>", desc = "find notifications", silent = true },
		{ "<leader>ft", ":lua Snacks.picker.todo_comments()<CR>", desc = "find todos", silent = true },
		{ "<leader>gl", ":lua Snacks.lazygit()<CR>", desc = "LazyGit", silent = true },
		{ "<leader>.", ":lua Snacks.scratch()<CR>", desc = "toggle scratch", silent = true },
		{ "<leader>e", ":lua Snacks.explorer()<CR>", desc = "toggle scratch", silent = true },
	},
}
