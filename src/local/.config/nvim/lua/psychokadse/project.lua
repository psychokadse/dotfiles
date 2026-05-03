local util = require("lspconfig.util")

local M = {}

function M.get_git_root()
    local expanded = vim.fn.expand("%:p")
    if expanded == "" then
        expanded = vim.uv.cwd()
    end
    return util.root_pattern(".git")(expanded)
end

function M.get_lsp_root()
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        local root = client.config.root_dir
        if root and vim.startswith(vim.api.nvim_buf_get_name(0), root) then
            return root
        end
    end
end

function M.get_root()
    return M.get_lsp_root() or M.get_git_root() or vim.uv.cwd()
end

-- switch to root if cwd is not root
function M.ensure_root()
    local root = M.get_root()
    if root and vim.uv.cwd() ~= root then
        vim.api.nvim_set_current_dir(root)
    end
end

return M
