local lsp = require('lsp-zero')
require('mason').setup()
require('mason-lspconfig').setup {
	ensure_installed = {
		"bashls",
		"lua_ls",
		"pylsp"
	}
}

lsp.preset('recommended')

local lspconfig = require('lspconfig')

lspconfig.bashls.setup({
	filetypes = { 'bash', 'sh', 'zsh' }
})
lspconfig.clangd.setup({})
lspconfig.java_language_server.setup({
	handlers = {
		['client/registerCapability'] = function(err, result, ctx, config)
			local registration = {
				registrations = { result },
			}
			return vim.lsp.handlers['client/registerCapability'](err, registration, ctx, config)
		end
	}
})
lspconfig.lua_ls.setup({})
lspconfig.pylsp.setup({})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

cmp.setup({
	mapping = cmp_mappings
})

--[[
lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end)
--]]

lsp.setup()

