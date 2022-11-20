-- True color support
vim.opt.termguicolors = true

-- Dynamically update window title
vim.opt.title = true

-- Keep the cursor centered
vim.opt.scrolloff = 999

-- Hide mode in command prompt
vim.opt.showmode = false

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
vim.opt.smartindent = true

-- Set leader key to space
vim.g.mapleader = " "

-- Enable completion
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
