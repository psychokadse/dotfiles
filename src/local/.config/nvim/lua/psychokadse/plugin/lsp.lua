return function()
    local servers = {
        emmet_ls = function()
            local caps = vim.lsp.protocol.make_client_capabilities()
            caps.textDocument.completion.completionItem.snippetSupport = true

            return {
                capabilities = caps,
                filetypes = { "css", "html", "javascript", "scss", "typescript" },
            }
        end,
        bashls = {
            filetypes = { "bash", "sh", "zsh" },
        },
    }

    local function on_attach(_, bufnr)
        local function opts(desc)
            return { desc = desc or "", buffer = bufnr, remap = false }
        end

        -- Restore default behavior of opening manual entry
        if vim.fn.maparg("K", "n") ~= "" then
            vim.keymap.del("n", "K", opts())
        end

        vim.keymap.set({ "n", "i" }, "<leader>K", vim.lsp.buf.hover, opts("vim.lsp.buf.hover()"))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("vim.lsp.buf.definition()"))
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts("vim.lsp.buf.workspace_symbol()"))
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts("vim.diagnostic.open_float()"))
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts("vim.diagnostic.goto_next()"))
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts("vim.diagnostic.goto_prev()"))
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts("vim.lsp.buf.code_action()"))
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts("vim.lsp.buf.references()"))
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts("vim.lsp.buf.rename()"))
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("vim.lsp.buf.signature_help()"))
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local function setup(server, opts)
        if type(opts) == "function" then
            opts = opts()
        end

        opts = opts or {}
        opts.capabilities = opts.capabilities or capabilities
        opts.on_attach = opts.on_attach or on_attach

        vim.lsp.config(server, opts)
        vim.lsp.enable(server)
    end

    local function setup_all(list, overrides)
        for _, server in ipairs(list) do
            local lspconfig = server.lspconfig
            setup(lspconfig, overrides[lspconfig])
        end
    end

    local tools = require("psychokadse.tools")

    setup_all(tools.registry.lsp, servers)
end
