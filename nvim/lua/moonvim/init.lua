for _, source in ipairs {
    "moonvim.plugins.color_gruvbox",
    "moonvim.plugins.color_onedark",
    "moonvim.plugins.color_vscode",

    "moonvim.packer",
    "moonvim.colorscheme",
    "moonvim.options",
    "moonvim.keymaps",
    "moonvim.functions",
    "moonvim.autocommands",
    "moonvim.utils",

    "moonvim.plugins.alpha",
    "moonvim.plugins.autopairs",
    "moonvim.plugins.cmp",
    "moonvim.plugins.commenter",
    "moonvim.plugins.lspconfig",
    "moonvim.plugins.lualine",
    "moonvim.plugins.telescope",
    "moonvim.plugins.treesitter",
} do
    local status_ok, fault = pcall(require, source)
    if not status_ok then
        vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
    end
end
