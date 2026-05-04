-- Always :cd into project root to prevent tooling pain
local last_root

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "LspAttach" }, {
    callback = function()
        local project = require("psychokadse.core.project")
        local root = project.get_root()

        if root and root ~= last_root then
            last_root = root
            project.ensure_root()
        end
    end,
})
