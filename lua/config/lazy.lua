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
	{ import = "config/plugins" },
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
	{
		"dankuri/tailwind-sorter.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm ci && npm run build",
		branch = "fix-default-queries",
		opts = {
			on_save_enabled = true,
			trim_spaces = true,
			on_save_pattern = { "*.html", "*.jsx", "*.tsx", "*.heex", "*.ex", "*.exs" },
		},
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
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
				function()
					require("which-key").show({ global = false })
				end,
				desc = "which-key",
			},
		},
	},
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
		"mrjones2014/smart-splits.nvim",
		dependencies = { "kwkarlwang/bufresize.nvim", opts = {} },
		opts = {
			at_edge = "stop",
			resize_mode = {
				silent = true,
				hooks = {
					on_leave = function()
						require("bufresize").register()
					end,
				},
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
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
			keymaps = {
				["<C-d>"] = "actions.preview_scroll_down",
				["<C-u>"] = "actions.preview_scroll_up",
			},
		},
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
				dashboard.button("e", "  Explore files", "<cmd>e .<CR>"),
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
