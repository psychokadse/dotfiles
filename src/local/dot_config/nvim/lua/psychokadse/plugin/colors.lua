return function()
    local color = "tokyonight"

    require(color).setup({
        style = "moon",
        transparent = true,
        terminal_colors = true,
        styles = {
            floats = "transparent",
        },
        on_highlights = function(hl, colors)
            hl.LineNr = { fg = colors.orange }
            hl.LineNrAbove = { fg = colors.dark5 }
            hl.LineNrBelow = { fg = colors.dark5 }
            -- which-key.nvim
            hl.WhichKeyNormal = { blend = 100 }
            -- nvim-tree.lua
            hl.NvimTreeNormal = { blend = 100 }
            hl.NvimTreeNormalFloat = { blend = 100 }
            hl.NvimTreeNormalNC = { blend = 100 }
            hl.NvimTreeOpenedHL = { fg = colors.orange }
        end,
    })

    vim.cmd.colorscheme(color)
end
