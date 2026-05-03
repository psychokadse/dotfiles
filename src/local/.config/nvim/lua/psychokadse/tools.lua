local M = {}

M.registry = {
    linters = {
        "commitlint",
        "cspell",
        "mypy",
        "ruff",
    },
    formatters = {
        "latexindent",
        "nixfmt",
        "prettier",
        "stylua",
    },
    lsp = {
        { name = "awk-language-server", lspconfig = "awk_ls" },
        { name = "bash-language-server", lspconfig = "bashls" },
        { name = "clangd", lspconfig = "clangd" },
        { name = "css-lsp", lspconfig = "cssls" },
        { name = "docker-compose-language-service", lspconfig = "docker_compose_language_service" },
        { name = "dockerfile-language-server", lspconfig = "dockerls" },
        { name = "emmet-ls", lspconfig = "emmet_ls" },
        { name = "eslint-lsp", lspconfig = "eslint" },
        { name = "haskell-language-server", lspconfig = "hls" },
        { name = "html-lsp", lspconfig = "html" },
        { name = "lua-language-server", lspconfig = "lua_ls" },
        { name = "nil", lspconfig = "nil_ls" },
        { name = "python-lsp-server", lspconfig = "pylsp" },
        { name = "rust-analyzer", lspconfig = "rust_analyzer" },
        { name = "texlab", lspconfig = "texlab" },
        { name = "typescript-language-server", lspconfig = "ts_ls" },
    },
}

function M.flatten(t)
    local out = {}

    for k, v in pairs(t) do
        for _, item in ipairs(v) do
            if k == "lsp" then
                out[#out + 1] = item.name
            else
                out[#out + 1] = item
            end
        end
    end

    return out
end

return M
