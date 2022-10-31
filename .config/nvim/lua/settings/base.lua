-- True color support
vim.opt.termguicolors = true

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Color bar at column 125 (because GitHub shows up to that)
vim.opt.colorcolumn = "125"

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set leader key to space
vim.g.mapleader = " "

-- Enable completion
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
