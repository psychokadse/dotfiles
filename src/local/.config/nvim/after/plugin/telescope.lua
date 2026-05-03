local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", function()
    builtin.find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
end)
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > "), use_regex = true, additional_args = { "--hidden" } }) -- Additional args correspond to ripgrep CLI args
end)

local telescope = require("telescope")
telescope.load_extension("harpoon")

vim.keymap.set("n", "<leader>hf", function()
    telescope.extensions.harpoon.marks()
end)
