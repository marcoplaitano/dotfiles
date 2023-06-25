local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

autopairs.setup({
    disable_in_macro = true,
    disable_in_replace_mode = true,
    disable_in_visual_block = true,
    enable_moveright = true,
    enable_check_bracket_line = true,
    enable_bracket_in_quote = true,
    enable_afterquote = true,
    break_undo = false
})
