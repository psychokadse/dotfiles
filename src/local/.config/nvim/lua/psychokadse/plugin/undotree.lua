return function()
    -- TODO Configure keymaps for undotree
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

    vim.g.undotree_DiffAutoOpen = 1
    vim.g.undotree_SetFocusWhenToggle = 1
end
