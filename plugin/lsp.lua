vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
})
require("mason").setup()

vim.diagnostic.config({
	float = {
		border = "rounded",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local bufnr = event.buf
		local id = vim.tbl_get(event, "data", "client_id")
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then
			return
		end

		local inlay_hint = vim.lsp.inlay_hint
		local no_inlay_hints = { "clangd" }
		if not vim.tbl_contains(no_inlay_hints, client.name) then
			inlay_hint.enable(true, { bufnr = bufnr })
		end

		local map = function(m, lhs, rhs, desc, silent)
			if desc then
				desc = "LSP: " .. desc
			end
			local key_opts = { buffer = bufnr, desc = desc, nowait = true, silent = silent }
			vim.keymap.set(m, lhs, rhs, key_opts)
		end

		map({ "i", "n" }, "<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "signature help")
		map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "hover documentation")
		map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "goto previous diagnostic message")
		map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "goto next diagnostic message")
		map("n", "gr", Snacks.picker.lsp_references, "goto references")
		map("n", "gi", Snacks.picker.lsp_implementations, "goto implementation")
		map("n", "go", Snacks.picker.lsp_type_definitions, "goto type definition")
		map("n", "gd", Snacks.picker.lsp_definitions, "goto definition")
		map("n", "gD", Snacks.picker.lsp_declarations, "goto declaration")
		map("n", "<leader>rn", vim.lsp.buf.rename, "rename")
		map("n", "<leader>fm", vim.lsp.buf.format, "format")
		map("x", "<leader>fm", vim.lsp.buf.format, "format selection")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "code actions")
		map("n", "<leader>cl", vim.lsp.codelens.run, "code lens")
		map("n", "<leader>th", function() inlay_hint.enable(not inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr }) end, "toggle inlay hints")
		map("n", "<leader>tH", function() inlay_hint.enable(not inlay_hint.is_enabled()) end, "toggle inlay hints globally")
	end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			hint = {
				paramName = "Disable",
			},
		},
	},
})
vim.lsp.enable("lua_ls")

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			completeUnimported = true,
			analyses = {
				unusedparams = true,
				unusedwrite = true,
				ST1000 = false,
				ST1003 = false,
			},
			staticcheck = true,
			hints = {
				-- assignVariableTypes = true,
				compositeLiteralFields = true,
				-- compositeLiteralTypes = true,
				constantValues = true,
				-- functionTypeParameters = true,
				-- parameterNames = true,
				-- rangeVariableTypes = true,
			},
		},
	},
})
vim.lsp.enable("gopls")
