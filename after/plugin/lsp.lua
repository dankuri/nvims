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

lsp.skip_server_setup({ "rust_analyzer" })

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

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["C-y"] = cmp.mapping.confirm({ select = true }),
		-- ["<CR>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = false,
		-- }),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_locally_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.locally_jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "crates" },
		{ name = "buffer" },
	},
})
