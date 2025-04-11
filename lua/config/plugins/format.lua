return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				elixir = { "mix" },
				lua = { "stylua" },
				go = { "goimports", "gofmt", "injected" },
				python = { "black" },
				sql = { "sqruff" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				typescript = { "prettier" },
				javascript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
				vue = { "prettier" },
				yaml = { "prettier" },
			},
			format_after_save = function(bufnr)
				if vim.b[bufnr].disable_autoformat then
					return
				end

				local disabled_formatting_lsp_names = {
					"ts_ls",
					"volar",
					"lua_ls",
				}
				return {
					async = true, -- let's try this
					lsp_format = "fallback",
					filter = function(client)
						return not vim.tbl_contains(disabled_formatting_lsp_names, client.name)
					end,
				}
			end,
		})
	end,
}
