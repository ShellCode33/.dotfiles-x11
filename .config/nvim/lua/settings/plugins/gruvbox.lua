vim.o.background = "dark"

require("gruvbox").setup({
    overrides = {
        -- | operator could be confused with / when using italic
        Operator = {italic = false}
    }
})

vim.cmd([[colorscheme gruvbox]])
