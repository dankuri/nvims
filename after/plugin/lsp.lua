local lsp = require("lsp-zero").preset({})

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"gopls",
	"html",
	"cssls",
	"emmet_ls",
	"volar",
	"lua_ls",
	"jsonls",
	"docker_compose_language_service",
	"dockerls",
	"intelephense",
	"tailwindcss",
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
	nmap("[d", vim.diagnostic.goto_prev, "goto previous diagnostic message")
	nmap("]d", vim.diagnostic.goto_next, "goto next diagnostic message")

	nmap("<leader>ca", vim.lsp.buf.code_action, "code actions")
	nmap("<leader>rn", vim.lsp.buf.rename, "rename")
	nmap("<leader>fm", vim.lsp.buf.format, "format")
end)

lsp.setup()
