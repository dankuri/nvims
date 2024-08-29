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
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			telescope.load_extension("ui-select")
		end,
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
			{ "hrsh7th/cmp-cmdline" },

			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
			},
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
		"Jay-Madden/auto-fix-return.nvim",
		opts = {},
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
		opts = {
			icons = {
				rules = false,
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
	{ "nvim-focus/focus.nvim", opts = {} },
	{
		"echasnovski/mini.files",
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
		config = function(_, opts)
			require("mini.files").setup(opts)

			-- from LazyVim
			local show_dotfiles = true
			local filter_show = function(fs_entry)
				return true
			end
			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				require("mini.files").refresh({ content = { filter = new_filter } })
			end

			local map_split = function(buf_id, lhs, direction, close_on_file)
				local rhs = function()
					local new_target_window
					local cur_target_window = require("mini.files").get_target_window()
					if cur_target_window ~= nil then
						vim.api.nvim_win_call(cur_target_window, function()
							vim.cmd("belowright " .. direction .. " split")
							new_target_window = vim.api.nvim_get_current_win()
						end)

						require("mini.files").set_target_window(new_target_window)
						require("mini.files").go_in({ close_on_file = close_on_file })
					end
				end

				local desc = "Open in " .. direction .. " split"
				if close_on_file then
					desc = desc .. " and close"
				end
				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
			end

			local files_set_cwd = function()
				local cur_entry_path = MiniFiles.get_fs_entry().path
				local cur_directory = vim.fs.dirname(cur_entry_path)
				if cur_directory ~= nil then
					vim.fn.chdir(cur_directory)
				end
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id

					vim.keymap.set(
						"n",
						opts.mappings and opts.mappings.toggle_hidden or "g.",
						toggle_dotfiles,
						{ buffer = buf_id, desc = "Toggle hidden files" }
					)

					vim.keymap.set(
						"n",
						opts.mappings and opts.mappings.change_cwd or "gc",
						files_set_cwd,
						{ buffer = args.data.buf_id, desc = "Set cwd" }
					)

					map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
					map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
					map_split(
						buf_id,
						opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S",
						"horizontal",
						true
					)
					map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
				end,
			})

			-- vim.api.nvim_create_autocmd("User", {
			-- 	pattern = "MiniFilesActionRename",
			-- 	callback = function(event)
			-- 		LazyVim.lsp.on_rename(event.data.from, event.data.to)
			-- 	end,
			-- })

			-- from https://gist.github.com/bassamsdata/eec0a3065152226581f8d4244cce9051 -- git status implementation

			local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
			local autocmd = vim.api.nvim_create_autocmd
			local _, MiniFiles = pcall(require, "mini.files")

			-- Cache for git status
			local gitStatusCache = {}
			local cacheTimeout = 2000 -- Cache timeout in milliseconds

			---@type table<string, {symbol: string, hlGroup: string}>
			---@param status string
			---@return string symbol, string hlGroup
			local function mapSymbols(status)
				local statusMap = {
					-- stylua: ignore start
					[" M"] = { symbol = "•", hlGroup = "GitSignsChange" }, -- Modified in the working directory
					["M "] = { symbol = "✹", hlGroup = "GitSignsChange" }, -- modified in index
					["MM"] = { symbol = "≠", hlGroup = "GitSignsChange" }, -- modified in both working tree and index
					["A "] = { symbol = "+", hlGroup = "GitSignsAdd" }, -- Added to the staging area, new file
					["AA"] = { symbol = "≈", hlGroup = "GitSignsAdd" }, -- file is added in both working tree and index
					["D "] = { symbol = "-", hlGroup = "GitSignsDelete" }, -- Deleted from the staging area
					["AM"] = { symbol = "⊕", hlGroup = "GitSignsChange" }, -- added in working tree, modified in index
					["AD"] = { symbol = "-•", hlGroup = "GitSignsChange" }, -- Added in the index and deleted in the working directory
					["R "] = { symbol = "→", hlGroup = "GitSignsChange" }, -- Renamed in the index
					["U "] = { symbol = "‖", hlGroup = "GitSignsChange" }, -- Unmerged path
					["UU"] = { symbol = "⇄", hlGroup = "GitSignsAdd" }, -- file is unmerged
					["UA"] = { symbol = "⊕", hlGroup = "GitSignsAdd" }, -- file is unmerged and added in working tree
					["??"] = { symbol = "?", hlGroup = "GitSignsDelete" }, -- Untracked files
					["!!"] = { symbol = "!", hlGroup = "GitSignsChange" }, -- Ignored files
					-- stylua: ignore end
				}

				local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
				return result.symbol, result.hlGroup
			end

			---@param cwd string
			---@param callback function
			---@return nil
			local function fetchGitStatus(cwd, callback)
				local function on_exit(content)
					if content.code == 0 then
						callback(content.stdout)
						vim.g.content = content.stdout
					end
				end
				vim.system({ "git", "status", "--ignored", "--porcelain" }, { text = true, cwd = cwd }, on_exit)
			end

			---@param str string?
			local function escapePattern(str)
				return str:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
			end

			---@param buf_id integer
			---@param gitStatusMap table
			---@return nil
			local function updateMiniWithGit(buf_id, gitStatusMap)
				vim.schedule(function()
					local nlines = vim.api.nvim_buf_line_count(buf_id)
					local cwd = vim.fs.root(buf_id, ".git")
					local escapedcwd = escapePattern(cwd)
					if vim.fn.has("win32") == 1 then
						escapedcwd = escapedcwd:gsub("\\", "/")
					end

					for i = 1, nlines do
						local entry = MiniFiles.get_fs_entry(buf_id, i)
						if not entry then
							break
						end
						local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
						local status = gitStatusMap[relativePath]

						if status then
							local symbol, hlGroup = mapSymbols(status)
							vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
								-- NOTE: if you want the signs on the right uncomment those and comment
								-- the 3 lines after
								-- virt_text = { { symbol, hlGroup } },
								-- virt_text_pos = "right_align",
								sign_text = symbol,
								sign_hl_group = hlGroup,
								priority = 2,
							})
						else
						end
					end
				end)
			end

			-- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
			---@param content string
			---@return table
			local function parseGitStatus(content)
				local gitStatusMap = {}
				-- lua match is faster than vim.split (in my experience )
				for line in content:gmatch("[^\r\n]+") do
					local status, filePath = string.match(line, "^(..)%s+(.*)")
					-- Split the file path into parts
					local parts = {}
					for part in filePath:gmatch("[^/]+") do
						table.insert(parts, part)
					end
					-- Start with the root directory
					local currentKey = ""
					for i, part in ipairs(parts) do
						if i > 1 then
							-- Concatenate parts with a separator to create a unique key
							currentKey = currentKey .. "/" .. part
						else
							currentKey = part
						end
						-- If it's the last part, it's a file, so add it with its status
						if i == #parts then
							gitStatusMap[currentKey] = status
						else
							-- If it's not the last part, it's a directory. Check if it exists, if not, add it.
							if not gitStatusMap[currentKey] then
								gitStatusMap[currentKey] = status
							end
						end
					end
				end
				return gitStatusMap
			end

			---@param buf_id integer
			---@return nil
			local function updateGitStatus(buf_id)
				if not vim.fs.root(vim.uv.cwd(), ".git") then
					return
				end

				local cwd = vim.fn.expand("%:p:h")
				local currentTime = os.time()
				if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
					updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
				else
					fetchGitStatus(cwd, function(content)
						local gitStatusMap = parseGitStatus(content)
						gitStatusCache[cwd] = {
							time = currentTime,
							statusMap = gitStatusMap,
						}
						updateMiniWithGit(buf_id, gitStatusMap)
					end)
				end
			end

			---@return nil
			local function clearCache()
				gitStatusCache = {}
			end

			local function augroup(name)
				return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
			end

			autocmd("User", {
				group = augroup("start"),
				pattern = "MiniFilesExplorerOpen",
				-- pattern = { "minifiles" },
				callback = function()
					local bufnr = vim.api.nvim_get_current_buf()
					updateGitStatus(bufnr)
				end,
			})

			autocmd("User", {
				group = augroup("close"),
				pattern = "MiniFilesExplorerClose",
				callback = function()
					clearCache()
				end,
			})

			autocmd("User", {
				group = augroup("update"),
				pattern = "MiniFilesBufferUpdate",
				callback = function(sii)
					local bufnr = sii.data.buf_id
					local cwd = vim.fn.expand("%:p:h")
					if gitStatusCache[cwd] then
						updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
					end
				end,
			})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		lazy = false,
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
