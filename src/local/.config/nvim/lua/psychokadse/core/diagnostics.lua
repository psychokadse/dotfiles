-- Also show diagnostics when no LSP is attached
vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = true,
        border = "rounded",
    },
})
