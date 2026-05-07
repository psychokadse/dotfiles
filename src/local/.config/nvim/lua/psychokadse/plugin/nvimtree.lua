return function()
    -- disable netrw at the start
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        renderer = {
            highlight_opened_files = "name",
        },
        update_focused_file = {
            enable = true,
            update_root = {
                enable = true,
            },
        },
        view = {
            width = 35,
        },
    })
    local api = require("nvim-tree.api")

    -- Override netrw mapping
    vim.keymap.set("n", "<leader>pv", function()
        api.tree.open()
    end, { desc = "Focus NvimTree" })

    vim.keymap.set("n", "<leader>pc", function()
        api.tree.toggle({ focus = false })
    end, { desc = "Toggle NvimTree" })
end
