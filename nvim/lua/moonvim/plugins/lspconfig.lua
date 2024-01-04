--------------------------------------------------------------------------------
-- KEYBOARD MAPPINGS
--------------------------------------------------------------------------------

local utils = require("moonvim.utils")

-- Use an on_attach function to only map the following keys after the language
-- server actually attaches to the current buffer.
local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = 'rounded'})<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gb", ":1po<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end



--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------

-- Set icons for diagnostic signs.
local signs = {
    Error = "",
    Warn = "",
    Hint = "󰌵",
    Info = "󰋼"
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
})



--------------------------------------------------------------------------------
-- Ensure these LSPs are always installed.
--------------------------------------------------------------------------------

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "bashls",
        "clangd",
        "jsonls",
        "lua_ls",
        "pylsp",
        "vimls",
    },
    automatic_installation = true,
}



--------------------------------------------------------------------------------
-- Set up language servers.
--------------------------------------------------------------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Servers that require no specific configuration.
local servers = {
    'bashls',
    'clangd',
    'jsonls',
    'vimls',
}
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 50,
        }
    }
end

-- LUA LSP
require 'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 50,
    },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
}

-- PYTHON LSP
require 'lspconfig'.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 50,
    },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    -- https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
                    -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
                    ignore = {
                        'E225', 'E226', 'E266',
                        'E302', 'E303', 'E305', 'E306',
                        'E701', 'E702', 'E722', 'E741',
                        'W191', 'W291', 'W292', 'W293',
                        'W391'
                    },
                    maxLineLength = 120
                }
            }
        }
    }
}
