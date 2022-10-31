-- basic nvim settings
require("settings.base")

-- load plugins
require("plugins")

-- completion related setups
require("settings.lsp")
require("settings.completion")

-- setup treesitter
require("settings.treesitter")

-- setup plugins
require("settings.plugins.telescope")
require("settings.plugins.gruvbox")

-- keymappings
require("remaps")
