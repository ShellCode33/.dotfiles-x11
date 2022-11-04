local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd", -- C and C++
        "pyright", -- Python
        "esbonio", -- Sphinx
        "sumneko_lua", -- Lua
        "rust_analyzer", -- Rust
        "marksman", -- Markdown
        "jsonls", -- JSON
        "cmake", -- CMake
        "bashls", -- Bash
        "dockerls", -- Docker
    }
})

-- Merge lspconfig default capabilities and the ones cmp-nvim provides
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require("mason-lspconfig").setup_handlers {
    -- Default handler that will be called if no override is provided
    function (server_name)
        lspconfig[server_name].setup {}
    end,

    -- Setup overrides
    ["sumneko_lua"] = function ()
        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'},
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
    end
}
