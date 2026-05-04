return function()
    require("lualine").setup({
        options = {
            refresh = {
                statusline = 500,
                tabline = 500,
                winbar = 500,
            },
            component_separators = {
                left = "|",
                right = "|",
            },
            section_separators = {
                left = "",
                right = "",
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "windows" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    })
end
