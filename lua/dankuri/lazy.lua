local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
	{
		"Mofiqul/dracula.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			{
				"neovim/nvim-lspconfig",
				dependencies = {
					-- Useful status updates for LSP
					-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
					{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
					{ "nvimtools/none-ls.nvim" },
				},
			},
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			{
				"hrsh7th/nvim-cmp",
				dependencies = {
					{
						"windwp/nvim-autopairs",
						opts = {
							fast_wrap = {},
							disable_filetype = { "TelescopePrompt", "vim" },
						},
						config = function(_, opts)
							require("nvim-autopairs").setup(opts)

							-- setup cmp for autopairs
							local cmp_autopairs = require("nvim-autopairs.completion.cmp")
							require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
						end,
					},
				},
			},
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },

			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function()
			require("gopher").setup({
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "gotests",
					impl = "impl",
					iferr = "iferr",
				},
			})
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
				src = {
					cmp = {
						enabled = true,
					},
				},
			})
		end,
	},
	{
		"someone-stole-my-name/yaml-companion.nvim",
		ft = { "yaml" },
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		opts = {
			builtin_matchers = {
				kubernetes = { enabled = true },
			},
		},
		config = function(_, opts)
			local cfg = require("yaml-companion").setup(opts)
			require("lspconfig")["yamlls"].setup(cfg)
			require("telescope").load_extension("yaml_schema")
		end,
	},
	{ "towolf/vim-helm", ft = "helm" },
	{ "b0o/schemastore.nvim" },
	{ "folke/which-key.nvim", opts = {} },
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = "dracula",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = { char = "│" },
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"Trouble",
					"lazy",
					"mason",
				},
			},
		},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufEnter",
	},
	{
		"numToStr/Navigator.nvim",
		lazy = false,
		opts = { disable_on_zoom = true },
	},
	{
		"ThePrimeagen/harpoon",
		lazy = false,
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
	{
		"mbbill/undotree",
		event = "BufRead",
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {
			win_options = {
				signcolumn = "yes:2",
			},
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-d>"] = "actions.preview_scroll_down",
				["<C-u>"] = "actions.preview_scroll_up",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = true,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝",
				"⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇",
				"⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀",
				"⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀ ",
				"⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀",
				"⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀         ",
			}

			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", "<cmd>ene<CR>"),
				dashboard.button("e", "  Explore files", "<cmd>Oil<CR>"),
				dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
				dashboard.button("o", "  Old files", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("w", "  Grep word", "<cmd>Telescope live_grep<CR>"),
				dashboard.button("g", "  Git status", "<cmd>LazyGit<CR>"),
				dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
				dashboard.button("h", "󱡀  Harpoon", "<cmd>HarpoonMenu<CR>"),
				dashboard.button("m", "  Mason", "<cmd>Mason<CR>"),
				dashboard.button("q", "󰩈  Quit", "<cmd>qa<CR>"),
			}

			alpha.setup(dashboard.config)
		end,
	},
	{ "folke/zen-mode.nvim", opts = {} },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"luvit-meta/library",
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	"ThePrimeagen/vim-be-good",
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-completion",
	"kristijanhusak/vim-dadbod-ui",
	{
		"norcalli/nvim-colorizer.lua",
		opts = {
			"css",
			"javascript",
			"html",
			hyprlang = {
				rgb_fn = true,
			},
		},
	},
})
