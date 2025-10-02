return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				elixir = { "mix", "rustywind" },
				eelixir = { "mix", "rustywind" },
				heex = { "mix", "rustywind" },
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
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
				gdscript = { "gdformat" },
			},
			format_after_save = function(bufnr)
				if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
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
					filter = function(client) return not vim.tbl_contains(disabled_formatting_lsp_names, client.name) end,
				}
			end,
		})

		vim.api.nvim_create_user_command("ToggleFormat", function()
			vim.b.disable_autoformat = not vim.b.disable_autoformat
			print("Setting autoformatting to: " .. tostring(not vim.b.disable_autoformat))
		end, {})
		vim.api.nvim_create_user_command("ToggleFormatGlobal", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			print("Setting global autoformatting to: " .. tostring(not vim.g.disable_autoformat))
		end, {})

		vim.keymap.set("n", "<leader>tf", ":ToggleFormat<CR>", { desc = "toggle format", silent = true })
	end,
}
