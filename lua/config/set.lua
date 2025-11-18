vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.opt.cmdheight = 0
-- if vim.fn.has("nvim-0.12") == 1 then
-- 	require("vim._extui").enable({})
-- end

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
-- vim.cmd([[set nrformats+=alpha]])

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

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.spell = false
vim.opt.spelllang = "en_us"

vim.g.db_ui_use_nerd_fonts = 1

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
