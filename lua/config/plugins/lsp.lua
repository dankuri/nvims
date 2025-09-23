return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

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

				local no_inlay_hints = { "zls", "clangd" }
				vim.lsp.inlay_hint.enable(not vim.tbl_contains(no_inlay_hints, client.name))
				map("n", "<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, "toggle inlay hints")
			end,
		})

		local capabilities = require("blink-cmp").get_lsp_capabilities()

		lspconfig.util.default_config.capabilities =
			vim.tbl_deep_extend("force", lspconfig.util.default_config.capabilities, capabilities)

		local gdscript_opts = {
			capabilities = capabilities,
		}
		if vim.fn.has("win32") == 1 then
			-- Windows specific. Requires nmap installed (`winget install nmap`)
			gdscript_opts["cmd"] = { "ncat", "localhost", os.getenv("GDScript_Port") or "6005" }
		end

		vim.lsp.config("gdscript", gdscript_opts)

		vim.lsp.config("gopls", {
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

		vim.lsp.config("elixirls", {
			settings = {
				elixirLS = {
					dialyzerEnabled = false,
					fetchDeps = false,
				},
			},
		})

		vim.lsp.config("jsonls", {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		-- vue setup
		local vue_ls_installed = require("mason-registry").get_package("vue-language-server"):is_installed()

		if vue_ls_installed then
			local vue_ts_plugin_path = vim.fn.expand(
				"$MASON/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
			)

			vim.lsp.config("ts_ls", {
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
			})
		end

		vim.lsp.config("html", {
			filetypes = { "html", "templ", "elixir", "eelixir", "heex" },
			init_options = {
				provideFormatter = false,
			},
		})

		vim.lsp.config("emmet_language_server", {
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

		vim.lsp.config("zls", {
			settings = {
				zls = {
					-- disable noise
					enable_argument_placeholders = false,
					inlay_hints_show_variable_type_hints = false,
					inlay_hints_show_struct_literal_field_type = false,
					inlay_hints_show_parameter_name = false,
					inlay_hints_show_builtin = false,
					inlay_hints_exclude_single_argument = false,
					inlay_hints_hide_redundant_param_names = false,
					inlay_hints_hide_redundant_param_names_last_token = false,
					-- enable good stuff
					enable_build_on_save = true,
				},
			},
		})
	end,
	dependencies = {
		-- Useful status updates for LSP
		{ "j-hui/fidget.nvim", tag = "v1.6.1", opts = {} },
		{ "saghen/blink.cmp" },
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				automatic_enable = true,
				automatic_installation = false,
				ensure_installed = {},
			},
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					{
						"gopls",
						condition = function()
							return vim.fn.executable("go") == 1
						end,
					},
					{
						"golangci-lint",
						condition = function()
							return vim.fn.executable("go") == 1
						end,
					},
					{
						"buf_ls",
						condition = function()
							return vim.fn.executable("buf") == 1
						end,
					},
					"sqruff",

					"lua_ls",
					"stylua",

					{
						"elixirls",
						condition = function()
							return vim.fn.executable("elixir") == 1
						end,
					},

					"html",
					"cssls",
					"tailwindcss",
					"ts_ls",
					"emmet_language_server",
					"vue_ls",
					"prettier",
					"rustywind",

					"bashls",
					"jsonls",
					"yamlls",
					"dockerls",

					{
						"zls",
						condition = function()
							return vim.fn.executable("zig") == 1
						end,
					},
					{
						"codelldb",
						condition = function()
							return vim.fn.executable("zig") == 1
						end,
					},
					{
						"clangd",
						condition = function()
							return vim.fn.executable("clang") == 1
						end,
					},

					{
						"pylsp",
						condition = function()
							return vim.fn.executable("python") == 1
						end,
					},
					{
						"black",
						condition = function()
							return vim.fn.executable("python") == 1
						end,
					},

					{
						"gdtoolkit",
						condition = function()
							return vim.fn.filereadable(vim.fn.getcwd() .. "/project.godot") == 1
						end,
					},
				},
			},
		},
	},
}
