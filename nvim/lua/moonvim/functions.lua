vim.cmd([[

    " Remove trailing spaces and empty lines in the file.
    function! RemoveTrailingSpacesAndLines()
        " Do not actually execute script if the current is a markdown file.
        if (expand('%:e') == "md")
            return
        " Do not actually execute script if the current is a git diff file.
        elseif (expand('%:e') == "diff")
            return
        endif
        " Save current cursor position (l, c)
        let l = line(".")
        let c = col(".")
        " Execute find & replace for the lines and then for the spaces.
        %s#\($\n\s*\)\+\%$##e
        %s/\s\+$//e
        " Reset cursor to its original position.
        call cursor(l, c)
    endfunction

]])
