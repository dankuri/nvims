vim.g.no_plugin_maps = true
vim.pack.add({
	"https://github.com/romus204/tree-sitter-manager.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

require("tree-sitter-manager").setup({
	auto_install = true,
})

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
})

local to_move = require("nvim-treesitter-textobjects.move")
local to_select = require("nvim-treesitter-textobjects.select")

vim.keymap.set({ "x", "o" }, "af", function() to_select.select_textobject("@function.outer", "textobjects") end, { desc = "function" })
vim.keymap.set({ "x", "o" }, "if", function() to_select.select_textobject("@function.inner", "textobjects") end, { desc = "function" })
vim.keymap.set({ "x", "o" }, "ic", function() to_select.select_textobject("@class.inner", "textobjects") end, { desc = "class" })
vim.keymap.set({ "x", "o" }, "ac", function() to_select.select_textobject("@class.outer", "textobjects") end, { desc = "class" })
vim.keymap.set({ "x", "o" }, "aa", function() to_select.select_textobject("@parameter.outer", "textobjects") end, { desc = "argument" })
vim.keymap.set({ "x", "o" }, "ia", function() to_select.select_textobject("@parameter.inner", "textobjects") end, { desc = "argument" })
vim.keymap.set({ "x", "o" }, "ai", function() to_select.select_textobject("@conditional.outer", "textobjects") end, { desc = "conditional" })
vim.keymap.set({ "x", "o" }, "ii", function() to_select.select_textobject("@conditional.inner", "textobjects") end, { desc = "conditional" })

vim.keymap.set({ "n", "x", "o" }, "]f", function() to_move.goto_next_start("@function.outer", "textobjects") end, { desc = "next function" })
vim.keymap.set({ "n", "x", "o" }, "]c", function() to_move.goto_next_start("@class.outer", "textobjects") end, { desc = "next class" })
vim.keymap.set({ "n", "x", "o" }, "]a", function() to_move.goto_next_start("@parameter.outer", "textobjects") end, { desc = "next argument" })
vim.keymap.set({ "n", "x", "o" }, "]i", function() to_move.goto_next_start("@conditional.outer", "textobjects") end, { desc = "next conditional" })
vim.keymap.set({ "n", "x", "o" }, "]l", function() to_move.goto_next_start("@loop.outer", "textobjects") end, { desc = "next loop" })

vim.keymap.set({ "n", "x", "o" }, "[f", function() to_move.goto_previous_start("@function.outer", "textobjects") end, { desc = "prev function" })
vim.keymap.set({ "n", "x", "o" }, "[c", function() to_move.goto_previous_start("@class.outer", "textobjects") end, { desc = "prev class" })
vim.keymap.set({ "n", "x", "o" }, "[a", function() to_move.goto_previous_start("@parameter.outer", "textobjects") end, { desc = "prev argument" })
vim.keymap.set({ "n", "x", "o" }, "[i", function() to_move.goto_previous_start("@conditional.outer", "textobjects") end, { desc = "prev conditional" })
vim.keymap.set({ "n", "x", "o" }, "[l", function() to_move.goto_previous_start("@loop.outer", "textobjects") end, { desc = "prev loop" })
