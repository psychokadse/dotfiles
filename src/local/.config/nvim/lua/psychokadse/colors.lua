function ReconfigureColors(color)
    color = color or "tokyonight"

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalSB", { bg = "none" })

    require("tokyonight").setup({
        style = "moon",
        transparent = true,
        terminal_colors = true,
        on_highlights = function(hl, colors)
            hl.LineNr = { fg = colors.orange }
            hl.LineNrAbove = { fg = colors.dark5 }
            hl.LineNrBelow = { fg = colors.dark5 }
        end,
    })

    vim.cmd.colorscheme(color)
end

ReconfigureColors()
