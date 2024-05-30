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
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'folke/tokyonight.nvim',
		name = 'tokyonight',
		config = function()
			vim.cmd('colorscheme tokyonight')
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = vim.cmd.TSUpdate
	},
	'nvim-treesitter/playground',
	'mbbill/undotree',
	'tpope/vim-fugitive',
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			{
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
				'neovim/nvim-lspconfig',
				'hrsh7th/nvim-cmp',
				'hrsh7th/cmp-nvim-lsp',
				'L3MON4D3/LuaSnip'
			}
		}
	}
})
