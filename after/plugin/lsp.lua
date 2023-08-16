local lsp = require("lsp-zero").preset({})

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"gopls",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("gr", "<cmd>Telescope lsp_references<cr>", "goto references")
	nmap("gd", vim.lsp.buf.definition, "goto definition")
	nmap("gI", vim.lsp.buf.implementation, "goto implementation")

	nmap("<leader>ca", vim.lsp.buf.code_action, "code actions")
	nmap("<leader>rn", vim.lsp.buf.rename, "rename")
	nmap("<leader>lf", vim.lsp.buf.format, "format")
end)

lsp.setup()
