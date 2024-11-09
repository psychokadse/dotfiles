local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>h", function()
	local keycode = vim.fn.getchar() - 0x30
	if keycode >= 1 and keycode <= 9 then
		ui.nav_file(keycode)
	end
end)
