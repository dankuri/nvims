vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
-- vim.cmd([[set nrformats+=alpha]])

vim.opt.signcolumn = "yes"

vim.opt.swapfile = false
vim.opt.backup = false

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
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})

local claugroup = vim.api.nvim_create_augroup("cursorline", {})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	group = claugroup,
	callback = function(_)
		vim.wo.cursorline = true
	end,
	desc = "Enable cursorline",
})
vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
	group = claugroup,
	callback = function(_)
		vim.wo.cursorline = false
	end,
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
