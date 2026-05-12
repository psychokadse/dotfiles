return function()
    local treesitter = require("nvim-treesitter")

    local function start(bufnr, lang)
        -- start parser for lang in buffer
        vim.treesitter.start(bufnr, lang)

        -- enable treesitter features
        vim.bo[bufnr].syntax = "ON" -- additional vim regex syntax highlighting
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- treesitter-based indenting

        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()" -- treesitter-based folding
        vim.wo[0][0].foldmethod = "expr"
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" }, -- we want to match dynamically based on whether a parser and query are available
        callback = function(ev)
            -- get the parser name from the filetype, if available
            -- may return input string if no parser exists
            local lang = vim.treesitter.language.get_lang(ev.match)

            if vim.treesitter.language.add(lang) then
                start(ev.buf, lang)
                return
            end

            if not vim.list_contains(treesitter.get_available(), lang) then
                -- no parser exists for this filetype
                return
            end

            -- schedule the installation and start after event processing
            vim.schedule(function()
                treesitter.install(lang):wait(300000)

                -- try again after installation
                start(ev.buf, lang)
            end)
        end,
    })

    vim.keymap.set("n", "<leader>ti", vim.treesitter.inspect_tree, { desc = "Treesitter inspect tree" })
end
