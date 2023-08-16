local ok, null_ls = pcall(require, "null-ls")

if not ok then
	return
end

local sources = {
	null_ls.builtins.formatting.rustfmt,
	null_ls.builtins.formatting.prettierd.with({
		filetypes = {
			"html",
			"json",
			"markdown",
			"scss",
			"css",
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"vue",
			"yaml",
		},
	}),
	-- null_ls.builtins.diagnostics.eslint.with {
	--   command = "eslint_d",
	-- },
	-- null_ls.builtins.formatting.shfmt,
	null_ls.builtins.diagnostics.shellcheck.with({
		diagnostics_format = "#{m} [#{c}]",
	}),
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.gofumpt,
	null_ls.builtins.formatting.goimports_reviser,
	null_ls.builtins.formatting.golines,
	-- null_ls.builtins.diagnostics.revive,
	-- null_ls.builtins.diagnostics.golangci_lint
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
	local format_is_enabled = true
	vim.api.nvim_create_user_command("ToggleFormat", function()
		format_is_enabled = not format_is_enabled
		print("Setting autoformatting to: " .. tostring(format_is_enabled))
	end, {})
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				if not format_is_enabled then
					return
				end
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
	debug = false,
})
