vim.api.nvim_create_autocmd("FileType", {
    pattern = { "css", "cucumber", "html", "javascript", "json", "nix", "scss", "typescript" },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
    end,
})
