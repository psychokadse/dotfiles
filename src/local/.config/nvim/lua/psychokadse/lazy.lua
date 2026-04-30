local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "stevearc/conform.nvim",
        config = require("psychokadse.plugin.format"),
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        build = function()
            require("psychokadse.colors")
        end,
        config = function()
            require("psychokadse.colors")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = vim.cmd.TSUpdate,
        config = require("psychokadse.plugin.treesitter"),
    },
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "ThePrimeagen/harpoon",
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "mhartington/formatter.nvim",
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
    },
    {
        "mfussenegger/nvim-lint",
    },
})
