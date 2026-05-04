vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "go" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("go")
			end
			require("go.install").update_all_sync()
		end
	end,
})
vim.pack.add({
	"https://github.com/ray-x/go.nvim",
	"https://github.com/ray-x/guihua.lua",
})
require("go").setup({ gotests_template = "testify" })

vim.keymap.set("n", "<localleader>e", ":GoIfErr<CR>", { silent = true, desc = "GO: if err" })
vim.keymap.set("n", "<localleader>g", ":GoGenerate<CR>", { silent = true, desc = "GO: generate" })
vim.keymap.set("n", "<localleader>at", ":GoAddTag ", { desc = "GO: add tag" })
vim.keymap.set("n", "<localleader>fs", ":GoFillStruct<CR>", { silent = true, desc = "GO: fill struct" })
vim.api.nvim_create_user_command("GoAddTestP", function() require("go.gotests").fun_test(true) end, {})
