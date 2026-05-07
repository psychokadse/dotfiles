return function()
    -- toggle the fugitive status window on the current tabpage
    vim.keymap.set("n", "<leader>gs", function()
        for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if pcall(vim.api.nvim_win_get_var, winid, "fugitive_status") then
                vim.api.nvim_win_close(winid, false)
                return
            end
        end
        vim.cmd.Git()
    end, { desc = "Toggle fugitive status" })
end
