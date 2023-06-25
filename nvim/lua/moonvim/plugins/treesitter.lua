local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

treesitter.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "bash",
        "c",
        "gitignore",
        "json",
        "lua",
        "markdown",
        "python",
        "vim",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
    },

    incremental_selection = {
        enable = true
    },

    indent = {
        enable = true
    },

    autotag = {
        enable = true
    },

    context_commentstring = {
        enable = true,
        enable_autocmd = false
    },
}
