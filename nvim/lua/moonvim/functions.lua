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



    " Save the file, compile and run it as a program if it is recognized.
    function! CompileAndExecute()
        let l:filename = expand('%')
        let l:extension = expand('%:e')
        let l:supported_extensions = ["c", "cpp", "py", "sh", "java", "r", ""]
        if (index(l:supported_extensions, l:extension) >= 0)
            write
            execute ":!executer " . l:filename . " --execute"
        else
            echomsg "Unrecognized file"
        endif
    endfunction
    " Use F5 to run the program.
    nnoremap <F5> :call CompileAndExecute()<CR>

]])
