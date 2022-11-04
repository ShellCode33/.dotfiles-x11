-- basic nvim settings
require("settings.base")

-- load plugins
require("plugins")

-- completion related setups
require("settings.lsp")
require("settings.completion")

-- setup plugins
require("settings.plugins.treesitter")
require("settings.plugins.gruvbox")
require("settings.plugins.nvim-tree")
require("settings.plugins.telescope")
require("settings.plugins.lualine")

-- keymappings
require("remaps")
