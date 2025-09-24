return {
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "fredrikaverpil/neotest-golang", version = "*", dependencies = { "leoluz/nvim-dap-go" } },
			{ "jfpedroza/neotest-elixir" },
			{ "lawrence-laz/neotest-zig" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-golang")({
						runner = "gotestsum",
						go_test_args = {
							"-v",
							"-race",
							"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
						},
					}),
					require("neotest-zig")({
						dap = {
							adapter = "lldb",
						},
					}),
					require("neotest-elixir"),
				},
			})
		end,
		keys = {
			{
				"<leader>nr",
				function()
					require("neotest").run.run()
				end,
				desc = "TEST: run nearest test",
			},
			{
				"<leader>na",
				function()
					require("neotest").run.attach()
				end,
				desc = "TEST: attach to test",
			},
			{
				"<leader>nf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "TEST: run cur file test",
			},
			{
				"<leader>nA",
				function()
					require("neotest").run.run(vim.uv.cwd())
				end,
				desc = "TEST: run all tests",
			},
			{
				"<leader>nS",
				function()
					require("neotest").run.run({ suite = true })
				end,
				desc = "TEST: run test suite",
			},
			{
				"<leader>nl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "TEST: run last test",
			},
			{
				"<leader>ns",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "TEST: summary",
			},
			{
				"<leader>no",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "TEST: output",
			},
			{
				"<leader>nO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "TEST: output panel",
			},
			{
				"<leader>nt",
				function()
					require("neotest").run.stop()
				end,
				desc = "TEST: terminate",
			},
			{
				"<leader>dt",
				function()
					require("neotest").run.run({ suite = false, strategy = "dap" })
				end,
				desc = "DAP: debug nearest test",
			},
		},
	},
	{
		"andythigpen/nvim-coverage",
		version = "*",
		event = "VeryLazy",
		opts = {
			auto_reload = true,
		},
		keys = {
			{
				"<leader>cc",
				function()
					require("coverage").load(true)
				end,
				desc = "TEST: show coverage",
			},
			{
				"<leader>ct",
				function()
					require("coverage").toggle()
				end,
				desc = "TEST: toggle coverage",
			},
			{
				"<leader>cs",
				function()
					require("coverage").summary()
				end,
				desc = "TEST: coverage summary",
			},
		},
	},
}
