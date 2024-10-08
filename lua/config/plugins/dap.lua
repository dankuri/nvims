return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
			},
			"williamboman/mason.nvim",
		},
		config = function()
			require("dapui").setup()
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						name = "Remote attach",
						mode = "remote",
						request = "attach",
						connect = {
							host = "127.0.0.1",
							port = "38697",
						},
					},
				},
				delve = {
					port = "38697",
				},
			})

			local dap, dapui = require("dap"), require("dapui")

			local codelldb_path = vim.fn.exepath("codelldb")
			if codelldb_path ~= "" then
				dap.adapters.lldb = {
					type = "server",
					executable = {
						command = codelldb_path,
						args = { "--port", "${port}" },
					},
					name = "lldb",
					port = "${port}",
				}
				dap.configurations.zig = {
					{
						name = "LLDB: Launch",
						type = "lldb",
						request = "launch",
						program = "${workspaceFolder}/zig-out/bin/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
						args = {},
						runInTerminal = false,
					},
				}
			end

			local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
			if elixir_ls_debugger ~= "" then
				dap.adapters.mix_task = {
					type = "executable",
					command = elixir_ls_debugger,
				}
				dap.configurations.elixir = {
					{
						type = "mix_task",
						name = "mix (Default task)",
						request = "launch",
						projectDir = "${workspaceFolder}",
					},
					{
						type = "mix_task",
						name = "mix test",
						request = "launch",
						task = "test",
						taskArgs = { "--trace" },
						startApps = true,
						projectDir = "${workspaceFolder}",
					},
					{
						type = "mix_task",
						name = "phoenix server",
						task = "phx.server",
						request = "launch",
						projectDir = "${workspaceFolder}",
						exitAfterTaskReturns = false,
						debugAutoIneterpretAllModules = false,
					},
				}
			end

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>", { desc = "DAP: toggle breakpoing" })
			vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>", { desc = "DAP: start or continue" })
			vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", { desc = "DAP: step over" })
			vim.keymap.set("n", "<leader>di", ":DapStepInto<CR>", { desc = "DAP: step into" })
			vim.keymap.set("n", "<leader>du", ":DapStepOut<CR>", { desc = "DAP: step out" })
			vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>", { desc = "DAP: terminate" })

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "B", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
		end,
	},
}