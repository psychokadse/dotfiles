local lsp = require("lsp-zero")

local lsp_attach = function(_, bufnr)
    lsp.default_keymaps({ bufnr = bufnr })
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "lua_ls",
        "pylsp",
    },
})

lsp.extend_lspconfig({
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    lsp_attach = lsp_attach,
    float_border = "rounded",
    sign_text = true,
})

local lspconfig = require("lspconfig")

lspconfig.bashls.setup({
    filetypes = { "bash", "sh", "zsh" },
})

lspconfig.clangd.setup({})
lspconfig.lua_ls.setup({})
lspconfig.pylsp.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.eslint.setup({})
lspconfig.ts_ls.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.texlab.setup({})
lspconfig.awk_ls.setup({})
lspconfig.dockerls.setup({})
lspconfig.docker_compose_language_service.setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    filetypes = { "css", "html", "javascript", "scss", "typescript" },
})

local cmp = require("cmp")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-l>"] = cmp.mapping(function()
        if cmp.visible() then
            cmp.close()
        else
            cmp.complete()
        end
    end, { "i" }),
    ["<CR>"] = cmp.mapping(function(fallback)
        fallback()
    end),
})

cmp.setup({
    mapping = cmp_mappings,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local mappings = vim.api.nvim_get_keymap("n")
        for _, map in ipairs(mappings) do
            if map.lhs == "K" then
                vim.keymap.del("n", "K", { buffer = ev.buf })
            end
        end
    end,
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set({ "n", "i" }, "<leader>K", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
end)

lsp.setup()
