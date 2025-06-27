require("formatter").setup({
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        css = {
            require("formatter.filetypes.css").prettier,
        },
        html = {
            require("formatter.filetypes.html").prettier,
        },
        javascript = {
            require("formatter.filetypes.javascript").prettier,
        },
        json = {
            require("formatter.filetypes.json").prettier,
        },
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
        nix = {
            require("formatter.filetypes.nix").nixfmt,
        },
        python = {
            require("formatter.filetypes.python").isort,
            require("formatter.filetypes.python").black,
        },
        scss = {
            -- prettier uses the same underlying parser for scss as it does for css
            require("formatter.filetypes.css").prettier,
        },
        typescript = {
            require("formatter.filetypes.typescript").prettier,
        },
        -- Use the special '*' filetype for defining formatter configurations on any filtype
        ["*"] = {
            -- 'formatter.filetypes.any' defines default configurations for any filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})

-- Register autocmd to format the current file after save
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
    group = "__formatter__",
    command = ":FormatWrite",
})
