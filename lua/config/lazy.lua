local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "config/plugins" },
	{ "windwp/nvim-ts-autotag", opts = {} },
	{ "windwp/nvim-autopairs", opts = {} },
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"mistweaverco/kulala.nvim",
		ft = { "http", "rest" },
		opts = {},
	},
	{ "b0o/schemastore.nvim" },
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_start = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_start = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			completions = { lsp = { enabled = true } },
			checkbox = {
				custom = {
					todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
				},
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			icons = {
				rules = false,
			},
		},
		keys = {
			{
				"<leader>?",
				function() require("which-key").show({ global = false }) end,
				desc = "which-key",
			},
		},
	},
	{
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
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = "auto",
				component_separators = "|",
				section_separators = "",
			},
		},
	},
	{
		"mbbill/undotree",
		event = "BufRead",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Undotree" },
		},
	},
	{
		"mrjones2014/smart-splits.nvim",
		opts = { at_edge = "stop" },
	},
	{
		"kwkarlwang/bufresize.nvim",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"stevearc/quicker.nvim",
		ft = "qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {
			highlight = {
				load_buffers = true,
			},
			keys = {
				{
					">",
					function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
					desc = "expand quickfix context",
				},
				{
					"<",
					function() require("quicker").collapse() end,
					desc = "collapse quickfix context",
				},
			},
		},
		keys = {
			{ "<leader>q", function() require("quicker").toggle() end, desc = "toggle quickfix" },
		},
	},
	"ThePrimeagen/vim-be-good",
	-- ability to open file:row:column from cmdline
	"wsdjeg/vim-fetch",
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-completion",
	{
		"kristijanhusak/vim-dadbod-ui",
		keys = {
			{ "<leader>db", vim.cmd.DBUIToggle, desc = "DBUI", silent = true },
		},
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			"css",
			"javascript",
			"html",
			hyprlang = {
				rgb_fn = true,
			},
		},
	},
	{
		"nvzone/showkeys",
		cmd = "ShowkeysToggle",
		opts = {
			maxkeys = 5,
			show_count = true,
			position = "top-right",
		},
	},
})
