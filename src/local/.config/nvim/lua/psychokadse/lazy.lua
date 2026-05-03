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
    -- formatting
    {
        "stevearc/conform.nvim",
        config = require("psychokadse.plugin.format"),
    },

    -- linting
    {
        "mfussenegger/nvim-lint",
        config = require("psychokadse.plugin.lint"),
    },

    -- LSP tooling
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            local tools = require("psychokadse.tools")

            require("mason-tool-installer").setup({
                ensure_installed = tools.flatten(tools.registry),
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
    },

    -- completion stack
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- UI / visuals
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        config = function()
            require("psychokadse.colors")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- editor features
    "tpope/vim-fugitive",
    "mbbill/undotree",
    "ThePrimeagen/harpoon",

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = vim.cmd.TSUpdate,
        config = require("psychokadse.plugin.treesitter"),
    },
})
