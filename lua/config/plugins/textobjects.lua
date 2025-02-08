return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "function" },
						["if"] = { query = "@function.inner", desc = "function" },
						["ic"] = { query = "@class.inner", desc = "class" },
						["ac"] = { query = "@class.outer", desc = "class" },
						["aa"] = { query = "@parameter.outer", desc = "argument" },
						["ia"] = { query = "@parameter.inner", desc = "argument" },
						["ai"] = { query = "@conditional.outer", desc = "conditional" },
						["ii"] = { query = "@conditional.inner", desc = "conditional" },
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = { query = "@function.outer", desc = "next function" },
						["]c"] = { query = "@class.outer", desc = "next class" },
						["]a"] = { query = "@parameter.outer", desc = "next argument" },
						["]i"] = { query = "@conditional.outer", desc = "next conditional" },
						["]l"] = { query = "@loop.outer", desc = "next loop" },
					},
					goto_previous_start = {
						["[f"] = { query = "@function.outer", desc = "prev function" },
						["[c"] = { query = "@class.outer", desc = "prev class" },
						["[a"] = { query = "@parameter.outer", desc = "prev argument" },
						["[i"] = { query = "@conditional.outer", desc = "prev conditional" },
						["[l"] = { query = "@loop.outer", desc = "prev loop" },
					},
				},
			},
		})

		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- Repeat movement with ; and ,
		-- ensure ; goes forward and , goes backward regardless of the last direction
		-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		-- vim way: ; goes to the direction you were moving.
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end,
}
