local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
    return
end


catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {     -- :h background
        light = "latte",
        dark = "mocha",
    },
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = true,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.95,
    },
    styles = {
        comments = { "italic", "bold" },
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = function(colors)
        return {
            Comment = { fg = colors.surface2 },
            StatusLine = { bg = colors.surface0 },
            StatusNormal = { bg = colors.blue, fg = colors.mantle },
            StatusInsert = { bg = colors.green, fg = colors.mantle },
            StatusVisual = { bg = colors.flamingo, fg = colors.mantle },
            StatusCommand = { bg = colors.pink, fg = colors.mantle },
            StatusReplace = { bg = colors.red, fg = colors.surface0 },
            StatusTerminal = { bg = colors.peach, fg = colors.surface0 },
            StatusGit = { bg = colors.surface1 },
            StatusFlags = { bg = colors.mantle, fg = colors.sky },
            StatusPosition = { bg = colors.surface1 },
            GitGutterAdd = { fg = colors.green },
            GitGutterChange = { fg = colors.blue },
            GitGutterDelete = { fg = colors.red },
            GitGutterChangeDelete = { fg = colors.red },
        }
    end,
    integrations = {
        cmp = true,
        gitsigns = true,
        gitgutter = true,
        nvimtree = true,
        markdown = true,
        treesitter = false,
    },
})
