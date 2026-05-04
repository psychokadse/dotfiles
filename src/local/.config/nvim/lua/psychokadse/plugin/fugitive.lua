return function()
    vim.keymap.set("n", "<leader>gs", function()
        for nr = 1, vim.fn.winnr("$") do
            if vim.fn.getwinvar(nr, "fugitive_status") ~= "" then
                vim.cmd.close({ count = nr })
                return
            end
        end
        vim.cmd.Git()
    end)
end
