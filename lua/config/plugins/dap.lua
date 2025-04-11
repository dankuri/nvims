return {
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

		dap.adapters.lldb = {
			type = "server",
			executable = {
				command = "codelldb",
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

		dap.adapters.mix_task = {
			type = "executable",
			command = "elixir-ls-debugger",
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
				debugAutoInterpretAllModules = false,
				startApps = false,
			},
		}

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

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoing", silent = true })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: start or continue", silent = true })
		vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = "DAP: disconnect", silent = true })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP: step over", silent = true })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: step into", silent = true })
		vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "DAP: step out", silent = true })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "DAP: restart", silent = true })
		vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "DAP: terminate", silent = true })
		vim.keymap.set("n", "<leader>dp", dapui.toggle, { desc = "DAP: toggle UI", silent = true })

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "B", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
	end,
}
