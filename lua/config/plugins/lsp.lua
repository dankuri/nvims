return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim", tag = "v1.4.5", opts = {} },
			{ "nvimtools/none-ls.nvim" },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")

			local buffer_autoformat = function(bufnr)
				local group = "lsp_autoformat"
				vim.api.nvim_create_augroup(group, { clear = false })
				vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					group = group,
					desc = "LSP format on save",
					callback = function()
						if vim.b.enable_autoformat then
							vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
						end
					end,
				})
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local bufnr = event.buf

					local id = vim.tbl_get(event, "data", "client_id")
					local client = id and vim.lsp.get_client_by_id(id)
					if client == nil then
						return
					end

					local map = function(m, lhs, rhs, desc, silent)
						if desc then
							desc = "LSP: " .. desc
						end
						local key_opts = { buffer = bufnr, desc = desc, nowait = true, silent = silent }
						vim.keymap.set(m, lhs, rhs, key_opts)
					end

					map("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, "hover documentation")
					map({ "i", "n" }, "<C-k>", function()
						vim.lsp.buf.signature_help({ border = "rounded" })
					end, "signature help")
					map("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "goto previous diagnostic message")
					map("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "goto next diagnostic message")
					map("n", "gr", ":Telescope lsp_references<cr>", "goto references", true)
					map("n", "gi", ":Telescope lsp_implementations<cr>", "goto implementation", true)
					map("n", "go", ":Telescope lsp_type_definitions<cr>", "goto type definition", true)
					map("n", "gd", ":Telescope lsp_definitions<cr>", "goto definition", true)
					map("n", "gD", vim.lsp.buf.declaration, "goto declaration")
					map("n", "<leader>rn", vim.lsp.buf.rename, "rename")
					map("n", "<leader>fm", vim.lsp.buf.format, "format")
					map("x", "<leader>fm", vim.lsp.buf.format, "format selection")
					map("n", "<leader>ca", vim.lsp.buf.code_action, "code actions")
					map("n", "<leader>cl", vim.lsp.codelens.run, "code lens")

					if client.name ~= "zls" then
						vim.lsp.inlay_hint.enable(true)
					end
					map("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "toggle inlay hints")

					if client.supports_method("textDocument/formatting", bufnr) then
						buffer_autoformat(bufnr)
					end

					vim.api.nvim_create_user_command("ToggleFormat", function()
						vim.b.enable_autoformat = not vim.b.enable_autoformat
						print("Setting autoformatting to: " .. tostring(vim.b.enable_autoformat))
					end, {})
					map("n", "<leader>tf", ":ToggleFormat<CR>", "toggle format")
				end,
			})

			lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig.util.default_config.capabilities,
				require("blink-cmp").get_lsp_capabilities()
			)

			vim.diagnostic.config({
				float = {
					border = "rounded",
				},
			})

			local disabled_formatting_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentFormattingRangeProvider = false
			end

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"buf_ls",
					"elixirls",
					"tailwindcss",
					"lua_ls",
					"jsonls",
					"yamlls",
					"dockerls",
					"bashls",
					"ts_ls",
					"html",
					"cssls",
					"emmet_language_server",
					"volar",
					"zls",
				},
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({})
					end,

					["gopls"] = function()
						lspconfig.gopls.setup({
							settings = {
								gopls = {
									completeUnimported = true,
									analyses = {
										unusedparams = true,
										unusedwrite = true,
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
					end,

					["elixirls"] = function()
						lspconfig.elixirls.setup({
							settings = {
								elixirLS = {
									dialyzerEnabled = false,
									fetchDeps = false,
								},
							},
						})
					end,

					-- for elixir heex templates
					["tailwindcss"] = function()
						lspconfig.tailwindcss.setup({
							root_dir = lspconfig.util.root_pattern(
								"tailwind.config.js",
								"tailwind.config.ts",
								"postcss.config.js",
								"postcss.config.ts",
								"package.json",
								"node_modules",
								".git",
								"mix.exs"
							),
							settings = {
								tailwindCSS = {
									includeLanguages = {
										elixir = "html-eex",
										eelixir = "html-eex",
										heex = "html-eex",
									},
									experimental = {
										classRegex = { 'class[:]\\s*"([^"]*)"' },
									},
								},
							},
						})
					end,

					["jsonls"] = function()
						lspconfig.jsonls.setup({
							settings = {
								json = {
									schemas = require("schemastore").json.schemas(),
									validate = { enable = true },
								},
							},
						})
					end,

					["helm_ls"] = function()
						lspconfig.helm_ls.setup({
							settings = {
								["helm-ls"] = {
									yamlls = {
										path = "yaml-language-server",
									},
								},
							},
						})
					end,

					-- vue setup
					["ts_ls"] = function()
						local ok, volar = pcall(require("mason-registry").get_package, "vue-language-server")

						if ok then
							local vue_ts_plugin_path = volar:get_install_path()
								.. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

							lspconfig.ts_ls.setup({
								filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
								init_options = {
									plugins = {
										{
											name = "@vue/typescript-plugin",
											location = vue_ts_plugin_path,
											languages = {
												"typescript",
												"javascript",
												"javascriptreact",
												"typescriptreact",
												"vue",
											},
										},
									},
								},
								on_attach = disabled_formatting_attach,
							})
						else
							lspconfig.ts_ls.setup({
								on_attach = disabled_formatting_attach,
							})
						end
					end,

					-- disable formatting
					["volar"] = function()
						lspconfig.volar.setup({
							on_attach = disabled_formatting_attach,
						})
					end,

					-- disable formatting
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							on_attach = disabled_formatting_attach,
						})
					end,

					["html"] = function()
						lspconfig.html.setup({
							filetypes = { "html", "templ", "elixir", "eelixir", "heex" },
							init_options = {
								provideFormatter = false,
							},
						})
					end,

					["clangd"] = function()
						lspconfig.clangd.setup({
							filetypes = { "c", "cpp" },
						})
					end,

					["emmet_language_server"] = function()
						lspconfig.emmet_language_server.setup({
							filetypes = {
								"htlm",
								"css",
								"javascriptreact",
								"typescriptreact",
								"vue",
								"eelixir",
								"heex",
							},
							init_options = {
								showSuggestionsAsSnippets = true,
							},
						})
					end,

					["zls"] = function()
						lspconfig.zls.setup({
							settings = {
								zls = {
									-- disable noise
									enable_argument_placeholders = false,
									-- enable good stuff
									enable_build_on_save = true,
								},
							},
						})
					end,
				},
			})
		end,
	},
}
