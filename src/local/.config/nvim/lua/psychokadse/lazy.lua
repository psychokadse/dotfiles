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
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = require("psychokadse.plugin.lsp"),
    },

    -- completion stack
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        config = require("psychokadse.plugin.cmp"),
    },

    {
        "debugloop/telescope-undo.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- optional but recommended
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = require("psychokadse.plugin.telescope"),
    },

    -- UI / visuals
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = require("psychokadse.plugin.colors"),
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = require("psychokadse.plugin.lualine"),
    },

    -- editor features
    {
        "folke/which-key.nvim",
        dependencies = {
            "nvim-mini/mini.icons",
        },
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = true })
                end,
                desc = "Show keymaps (which-key)",
            },
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = require("psychokadse.plugin.nvimtree"),
    },

    {
        "tpope/vim-fugitive",
        config = require("psychokadse.plugin.fugitive"),
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = require("psychokadse.plugin.harpoon"),
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = vim.cmd.TSUpdate,
        config = require("psychokadse.plugin.treesitter"),
    },
})
