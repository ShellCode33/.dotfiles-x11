local telescope = require("telescope.builtin")

local opts = { noremap=true, silent=true }

-- Keep selection when indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Moving lines in all modes
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("i", "<C-j>", "<esc>:m .+1<CR>==i", opts)
vim.keymap.set("i", "<C-k>", "<esc>:m .-2<CR>==i", opts)
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", opts)

-- Undo breakpoints
vim.keymap.set("i", ",", ",<C-g>u", opts)
vim.keymap.set("i", "?", "?<C-g>u", opts)
vim.keymap.set("i", "!", "!<C-g>u", opts)
vim.keymap.set("i", "-", "-<C-g>u", opts)
vim.keymap.set("i", ";", ";<C-g>u", opts)
vim.keymap.set("i", ":", ":<C-g>u", opts)
vim.keymap.set("i", "(", "(<C-g>u", opts)
vim.keymap.set("i", ")", ")<C-g>u", opts)
vim.keymap.set("i", "[", "[<C-g>u", opts)
vim.keymap.set("i", "]", "]<C-g>u", opts)
vim.keymap.set("i", "{", "{<C-g>u", opts)
vim.keymap.set("i", "}", "}<C-g>u", opts)

-- Fuzzy finder
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fs', telescope.current_buffer_fuzzy_find, {})

-- File explorer
vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", opts)
vim.keymap.set("i", "<C-t>", "<esc>:NvimTreeToggle<CR>", opts)
vim.keymap.set("v", "<C-t>", ":NvimTreeToggle<CR>", opts)

-- Format file
local function format_buf()
    vim.lsp.buf.format{ async = true }
end
vim.api.nvim_create_user_command("Format", format_buf, {})

-- LSP related mappings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

-- Add quickfix mapping
local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end
vim.keymap.set('n', '<leader>f', quickfix, opts)
