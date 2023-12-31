local status_ok, vscodeTheme = pcall(require, "vscode")
if not status_ok then
    return
end

vscodeTheme.setup({
    transparent = true,
    italic_comments = true,
    color_overrides = {
        vscLineNumber = '#a0a0a0',
    }
})

require("vscode").load()
