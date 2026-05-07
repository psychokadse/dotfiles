return function()
    local conform = require("conform")

    conform.setup({
        formatters_by_ft = {
            css = { "prettier" },
            html = { "prettier" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            nix = { "nixfmt" },
            python = { "ruff_format" },
            scss = { "prettier" },
            tex = { "latexindent" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
        },

        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },

        notify_on_error = true,
    })

    vim.keymap.set("n", "<leader>f", function()
        conform.format({ async = true })
    end, { desc = "Format buffer" })
end
