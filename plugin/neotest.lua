vim.pack.add({
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/fredrikaverpil/neotest-golang",
	"https://github.com/jfpedroza/neotest-elixir",
	"https://github.com/lawrence-laz/neotest-zig",
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/andythigpen/nvim-coverage",
})
local neotest = require("neotest")
neotest.setup({
	adapters = {
		require("neotest-golang")({
			runner = "gotestsum",
			go_test_args = {
				"-v",
				"-race",
				"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
			},
			warn_test_name_dupes = false,
		}),
		require("neotest-zig")({
			dap = {
				adapter = "lldb",
			},
		}),
		require("neotest-elixir"),
		require("rustaceanvim.neotest"),
	},
})

local coverage = require("coverage")
coverage.setup({ auto_reload = true })

vim.keymap.set("n", "<leader>nr", function() neotest.run.run() end, { desc = "TEST: run nearest test" })
vim.keymap.set("n", "<leader>na", function() neotest.run.attach() end, { desc = "TEST: attach to test" })
vim.keymap.set("n", "<leader>nf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "TEST: run cur file test" })
vim.keymap.set("n", "<leader>nA", function() neotest.run.run(vim.uv.cwd()) end, { desc = "TEST: run all tests" })
vim.keymap.set("n", "<leader>nS", function() neotest.run.run({ suite = true }) end, { desc = "TEST: run test suite" })
vim.keymap.set("n", "<leader>nl", function() neotest.run.run_last() end, { desc = "TEST: run last test" })
vim.keymap.set("n", "<leader>ns", function() neotest.summary.toggle() end, { desc = "TEST: summary" })
vim.keymap.set("n", "<leader>no", function() neotest.output.open({ enter = true, auto_close = true }) end, { desc = "TEST: output" })
vim.keymap.set("n", "<leader>nO", function() neotest.output_panel.toggle() end, { desc = "TEST: output panel" })
vim.keymap.set("n", "<leader>nt", function() neotest.run.stop() end, { desc = "TEST: terminate" })
vim.keymap.set("n", "<leader>dt", function() neotest.run.run({ suite = false, strategy = "dap" }) end, { desc = "DAP: debug nearest test" })
vim.keymap.set("n", "<leader>cc", function() coverage.load(true) end, { desc = "TEST: show coverage" })
vim.keymap.set("n", "<leader>ct", function() coverage.toggle() end, { desc = "TEST: toggle coverage" })
vim.keymap.set("n", "<leader>cs", function() coverage.summary() end, { desc = "TEST: coverage summary" })
