local lsp = require("lsp-zero").preset({})

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"gopls",
	"html",
	"cssls",
	"emmet_ls",
	"astro",
	"volar",
	"lua_ls",
	"jsonls",
	"dockerls",
	"bashls",
	"tailwindcss",
	"elixirls",
	"yamlls",
	"zls",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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

	vim.keymap.set({ "i", "n" }, "<C-K>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: signature help" })
	nmap("gr", "<cmd>Telescope lsp_references<cr>", "goto references")
	nmap("gd", vim.lsp.buf.definition, "goto definition")
	nmap("gI", vim.lsp.buf.implementation, "goto implementation")
	nmap("[d", vim.diagnostic.goto_prev, "goto previous diagnostic message")
	nmap("]d", vim.diagnostic.goto_next, "goto next diagnostic message")

	nmap("<leader>ca", vim.lsp.buf.code_action, "code actions")
	nmap("<leader>rn", vim.lsp.buf.rename, "rename")
	nmap("<leader>fm", vim.lsp.buf.format, "format")

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
end)

lsp.skip_server_setup({ "rust_analyzer" })

lsp.use("helm_ls", {
	settings = {
		["helm-ls"] = {
			yamlls = {
				path = "yaml-language-server",
			},
		},
	},
})

lsp.use("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

lsp.use("elixirls", {
	settings = {
		elixirLS = {
			dialyzerEnabled = true,
			incrementalDialyzer = true,
			suggestSpecs = true,
		},
	},
})

lsp.use("gopls", {
	settings = {
		gopls = {
			completeUnimported = true,
			analyses = {
				unusedparams = true,
				unusedwrite = true,
			},
			staticcheck = true,
		},
	},
})

local _, volar = pcall(require("mason-registry").get_package, "vue-language-server")

local vue_ts_plugin_path = volar:get_install_path()
	.. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

-- vue setup
lsp.use("tsserver", {
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
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
})

-- disable formatting
lsp.use("volar", {
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
})

lsp.setup()

local rust_tools = require("rust-tools")

rust_tools.setup({
	server = {
		on_attach = function(_, bufnr)
			vim.keymap.set(
				"n",
				"<leader>ca",
				rust_tools.hover_actions.hover_actions,
				{ buffer = bufnr, desc = "rust code actions" }
			)
		end,
	},
})
