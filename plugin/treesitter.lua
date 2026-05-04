vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})
vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})
vim.api.nvim_create_autocmd({ "BufRead" }, {
	callback = function(event)
		local bufnr = event.buf
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

		-- Skip if no filetype
		if filetype == "" then
			return
		end

		-- Get parser name based on filetype
		local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
		if not parser_name then
			return
		end
		-- Try to get existing parser (helpful check if filetype was returned above)
		local parser_configs = require("nvim-treesitter.parsers")
		if not parser_configs[parser_name] then
			return -- Parser not available, skip silently
		end

		local parser = vim.treesitter.get_parser(bufnr, parser_name)

		if not parser then
			-- If not installed, install parser synchronously
			require("nvim-treesitter").install({ parser_name }):wait(30000)
		end
		vim.treesitter.start(bufnr, parser_name)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
vim.g.no_plugin_maps = true
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
