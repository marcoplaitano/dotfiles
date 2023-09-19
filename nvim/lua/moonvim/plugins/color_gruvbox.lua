local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
    return
end

gruvbox.setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        comments = true,
        strings = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,     -- invert background for search, diffs, statusline and errors
    contrast = "hard",  -- soft, hard
    dim_inactive = false,
    transparent_mode = true,
})

require("gruvbox").load()
