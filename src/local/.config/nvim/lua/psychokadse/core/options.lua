-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indenting defaults
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- files
vim.opt.fileencoding = "utf-8"
vim.opt.isfname:append("@-@") -- include literal `@` in filename detection

-- text wrapping
vim.opt.wrap = false

-- swapfile
vim.opt.swapfile = false
vim.opt.updatetime = 50

-- file backups
vim.opt.backup = false

-- undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search
vim.opt.hlsearch = false -- persistent search highlighting is annoying
vim.opt.incsearch = true

-- ui
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "120" -- 120 should be enough as a soft limit for code
vim.opt.showmode = false -- lualine already shows the mode

-- mouse support
vim.opt.mouse = "" -- completely disable mouse support

-- folding
vim.opt.foldlevelstart = 99 -- start with all folds open
