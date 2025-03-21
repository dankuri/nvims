return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local ok, null_ls = pcall(require, "null-ls")

			if not ok then
				return
			end

			local sources = {
				-- for a full list check https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
				null_ls.builtins.formatting.mix,
				null_ls.builtins.formatting.prettierd.with({
					filetypes = {
						"astro",
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
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.black,

				null_ls.builtins.diagnostics.credo,
				null_ls.builtins.diagnostics.staticcheck,
				null_ls.builtins.diagnostics.golangci_lint,
			}

			null_ls.setup({
				sources = sources,
				debug = false,
			})
		end,
	},
}
