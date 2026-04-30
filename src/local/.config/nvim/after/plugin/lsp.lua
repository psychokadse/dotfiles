local registry = {
    linters = {
        "commitlint",
        "cspell",
        "mypy",
    },
    formatters = {
        "black",
        "isort",
        "latexindent",
        "nixfmt",
        "prettier",
        "stylua",
    },
    lsp = {
        "awk_ls",
        "bashls",
        "clangd",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "emmet_ls",
        "eslint",
        "hls",
        "html",
        "lua_ls",
        "nil_ls",
        "pylsp",
        "rust_analyzer",
        "texlab",
        "ts_ls",
    },
}

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

local function flatten(t)
    local out = {}

    for _, v in pairs(t) do
        for _, item in ipairs(v) do
            out[#out + 1] = item
        end
    end

    return out
end

require("mason-tool-installer").setup({
    ensure_installed = flatten(registry),
})

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- Restore default behavior of opening manual entry
    if vim.fn.maparg("K", "n") ~= "" then
        vim.keymap.del("n", "K", opts)
    end

    vim.keymap.set({ "n", "i" }, "<leader>K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
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
        setup(server, overrides[server])
    end
end

setup_all(registry.lsp, servers)

local cmp = require("cmp")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
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
