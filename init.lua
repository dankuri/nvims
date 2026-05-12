-- OPTIONS
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
-- vim.cmd([[set nrformats+=alpha]]) -- to incr/decr letters

vim.opt.signcolumn = "yes"

vim.opt.swapfile = false
vim.opt.backup = false

vim.o.secure = true
vim.o.exrc = true

if vim.uv.os_uname().sysname == "Windows_NT" then
	vim.opt.undodir = os.getenv("USERPROFILE") .. "\\.vim\\undodir"
else
	vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.spell = false
vim.opt.spelllang = "en_us"

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 }) end,
})

local claugroup = vim.api.nvim_create_augroup("cursorline", {})
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	group = claugroup,
	callback = function(_) vim.wo.cursorline = true end,
	desc = "Enable cursorline",
})
vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
	group = claugroup,
	callback = function(_) vim.wo.cursorline = false end,
	desc = "Disable cursorline",
})

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = true,
	}
end

-- Enable neovim to be the external editor for Godot, if the cwd has a project.godot file
if vim.fn.filereadable(vim.fn.getcwd() .. "/project.godot") == 1 then
	local addr = "./godot.pipe"
	if vim.fn.has("win32") == 1 then
		-- Windows can't pipe so use localhost. Make sure this is configured in Godot
		addr = "127.0.0.1:6004"
	end
	vim.fn.serverstart(addr)
end

require("vim._core.ui2").enable({})

-- REMAPS
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("", "<localleader>,", ",", { desc = "prev search" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "move highlighted block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "move highlighted block up" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "escape from insert" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "concat down without cursor moving" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "halfpage down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "halfpage up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "goto next search item (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "goto prev search item (centered)" })

vim.keymap.set("n", "M", ":Man<CR>", { desc = "open man page" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without copying" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy in sys clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy in sys clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]], { desc = "delete without copying" })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>u", vim.cmd.Undotree, { desc = "Undotree" })

vim.keymap.set("n", "<localleader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "substitute word" })
vim.keymap.set("n", "<localleader>x", ":!chmod +x %<CR>", { desc = "make file executable" })
vim.keymap.set("n", "<leader>x", ":bdel<CR>", { desc = "close buffer", silent = true })

vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "toggle wrap" })
vim.keymap.set("n", "<leader>tS", ":set spell!<CR>", { desc = "toggle spell" })

-- tabs
vim.keymap.set("n", "H", ":tabp<CR>", { desc = "prev tab", silent = true })
vim.keymap.set("n", "L", ":tabn<CR>", { desc = "next tab", silent = true })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "new tab", silent = true })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "close tab", silent = true })

-- move between panes & tmux splits with Alt + direction
vim.keymap.set({ "n", "t" }, "<M-h>", vim.cmd.SmartCursorMoveLeft, { desc = "cursor move left" })
vim.keymap.set({ "n", "t" }, "<M-l>", vim.cmd.SmartCursorMoveRight, { desc = "cursor move right" })
vim.keymap.set({ "n", "t" }, "<M-k>", vim.cmd.SmartCursorMoveUp, { desc = "cursor move up" })
vim.keymap.set({ "n", "t" }, "<M-j>", vim.cmd.SmartCursorMoveDown, { desc = "cursor move down" })

-- PLUGINS - general here and more speacialized in plugin/
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree")
-- vim.cmd.packadd("nohlsearch")
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/mrjones2014/smart-splits.nvim",
	"https://github.com/wsdjeg/vim-fetch", -- ability to open file:row:column from cmdline
	"https://github.com/tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically
	{ src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/b0o/schemastore.nvim",
})

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
vim.cmd.colorscheme("catppuccin-nvim")

require("nvim-web-devicons").setup({
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
})

require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = "|",
		section_separators = "",
	},
})

require("render-markdown").setup({})
require("which-key").setup({ icons = { rules = false } })
require("nvim-autopairs").setup({})
require("smart-splits").setup({ at_edge = "stop" })
require("nvim-surround").setup({})
