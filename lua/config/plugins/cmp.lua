return {
	"saghen/blink.cmp",
	dependencies = { { "rafamadriz/friendly-snippets" } },
	version = "*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-k>"] = { "select_prev", "fallback_to_mappings" },
			["<C-j>"] = { "select_next", "fallback_to_mappings" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
		},
		cmdline = {
			keymap = {
				["<Tab>"] = { "show", "accept" },
				["<C-k>"] = { "select_prev", "fallback_to_mappings" },
				["<C-j>"] = { "select_next", "fallback_to_mappings" },
			},
			completion = {
				menu = {
					auto_show = true,
					draw = {
						columns = { { "label" } },
					},
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			per_filetype = {
				sql = { "dadbod", "buffer" },
			},
			providers = {
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			},
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				window = {
					border = "rounded",
				},
			},
			menu = {
				draw = {
					-- this is the default one
					-- columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
					-- this is to match nvim-cmp
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
				},
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = function(ctx) return ctx.mode == "cmdline" end,
				},
			},
			ghost_text = { enabled = true },
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},
	},
	opts_extend = { "sources.default" },
}
