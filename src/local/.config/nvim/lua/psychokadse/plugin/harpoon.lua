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
    end)
    vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set("n", "<leader>p", function()
        harpoon:list():prev()
    end)

    vim.keymap.set("n", "<leader>n", function()
        harpoon:list():next()
    end)

    for i = 1, 9 do
        vim.keymap.set("n", "<leader>" .. i, function()
            harpoon:list():select(i)
        end)
    end
end
