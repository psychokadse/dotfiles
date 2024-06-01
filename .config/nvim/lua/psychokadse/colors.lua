function ReconfigureColors(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalSB", { bg = "none" })

	require('tokyonight').setup({
		style = 'storm',
		transparent = true,
		terminal_colors = true,
	})
end

ReconfigureColors()
