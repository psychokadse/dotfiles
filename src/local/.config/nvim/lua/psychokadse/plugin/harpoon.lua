return function()
    local harpoon = require("harpoon")
    local harpoon_extensions = require("harpoon.extensions")

    -- `setup` is required with harpoon2
    harpoon:setup({
        -- Custom config...
    })

    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    harpoon:extend(harpoon_extensions.builtins.navigate_with_number())

    vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
    end, { desc = "Add harpoon mark" })
    vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle harpoon quick menu" })

    vim.keymap.set("n", "<leader>p", function()
        harpoon:list():prev()
    end, { desc = "Prev harpoon mark" })

    vim.keymap.set("n", "<leader>n", function()
        harpoon:list():next()
    end, { desc = "Next harpoon mark" })

    for i = 1, 9 do
        vim.keymap.set("n", "<leader>" .. i, function()
            harpoon:list():select(i)
        end, { desc = "Harpoon mark " .. i })
    end
end
