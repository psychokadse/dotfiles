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

function M.flatten(t)
    local out = {}

    for _, v in pairs(t) do
        for _, item in ipairs(v) do
            out[#out + 1] = item
        end
    end

    return out
end

return M
