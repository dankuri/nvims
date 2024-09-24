local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")

local lsp_attach = function(client, bufnr)
	local map = function(m, lhs, rhs, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		local key_opts = { buffer = bufnr, desc = desc, nowait = true }
		vim.keymap.set(m, lhs, rhs, key_opts)
	end

	map("n", "K", vim.lsp.buf.hover, "hover documentation")
	map("n", "gr", ":Telescope lsp_references<cr>", "goto references")
	map("n", "gi", ":Telescope lsp_implementation<cr>", "goto implementation")
	map("n", "go", ":Telescope lsp_type_definition<cr>", "goto type definition")
	map("n", "gd", ":Telescope lsp_definitions<cr>", "goto definition")
	map("n", "gD", vim.lsp.buf.declaration, "goto declaration")
	map("n", "[d", vim.diagnostic.goto_prev, "goto previous diagnostic message")
	map("n", "]d", vim.diagnostic.goto_next, "goto next diagnostic message")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "code actions")
	map("n", "<leader>rn", vim.lsp.buf.rename, "rename")
	map("n", "<leader>fm", vim.lsp.buf.format, "format")
	map("x", "<leader>fm", vim.lsp.buf.format, "format selection")
	map({ "i", "n" }, "<C-K>", vim.lsp.buf.signature_help, "signature help")

	lsp_zero.buffer_autoformat()
	vim.api.nvim_create_user_command("ToggleFormat", function()
		vim.b.lsp_zero_enable_autoformat = not vim.b.lsp_zero_enable_autoformat
		print("Setting autoformatting to: " .. tostring(vim.b.lsp_zero_enable_autoformat))
	end, {})
end

lsp_zero.extend_lspconfig({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	lsp_attach = lsp_attach,
	sign_text = true,
	float_border = "rounded",
})

local disabled_formatting_attach = function(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentFormattingRangeProvider = false
end

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
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
		"emmet_ls",
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
						dialyzerEnabled = true,
						incrementalDialyzer = true,
						suggestSpecs = true,
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
								languages = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
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

		["html"] = function()
			lspconfig.html.setup({
				filetypes = { "html", "templ", "elixir", "eelixir", "heex" },
				init_options = {
					provideFormatter = false,
				},
			})
		end,

		["emmet_ls"] = function()
			lspconfig.emmet_ls.setup({
				filetypes = {
					"html",
					"css",
					"javascriptreact",
					"typescriptreact",
					"vue",
					"elixir",
					"eelixir",
					"heex",
				},
			})
		end,
	},
})

vim.lsp.inlay_hint.enable(true)
