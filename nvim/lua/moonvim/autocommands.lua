vim.cmd([[
    " Group all the commands to run based on the type of file in the buffer.
    augroup filetypeCommands
        autocmd!

        " Set ruler at column 100 for python files.
        autocmd FileType python setlocal colorcolumn=100
        autocmd FileType python setlocal textwidth=100

        " Set ruler at column 120 for java files.
        autocmd FileType java setlocal colorcolumn=120
        autocmd FileType java setlocal textwidth=120

        " Set ruler at column 120 for HTML files.
        autocmd Filetype html set textwidth=120
        autocmd Filetype html set colorcolumn=120

        autocmd FileType gitcommit setlocal spell
        autocmd FileType gitcommit setlocal textwidth=72
        autocmd FileType gitcommit setlocal colorcolumn=72

        " Disable line numbers in alpha dashboard.
        autocmd FileType alpha setlocal nonumber norelativenumber

        " Enable spellcheck.
        autocmd FileType markdown setlocal spell
        autocmd FileType gitcommit setlocal spell
        autocmd FileType text setlocal spell

        " Use hard tabs for makefiles.
        autocmd FileType make setlocal noexpandtab

        " Auto cd into buffer directory when editing vim config files.
        autocmd BufEnter *.vim setlocal autochdir

        " Set filetype for git files.
        autocmd BufEnter .gitignore setfiletype gitignore
        autocmd BufEnter git/ignore setfiletype gitignore
        autocmd BufEnter git/config setfiletype gitconfig

        " Set filetype for custom shell files.
        autocmd BufEnter *shell/* setfiletype sh
        autocmd BufEnter *bash* setfiletype sh
        autocmd BufEnter *zsh* setfiletype sh

        " Set filetype for crontab file.
        autocmd BufEnter cronjobs* setfiletype crontab
    augroup END



    " Group all the commands to run when entering vim or a new buffer.
    augroup entering
        autocmd!

        " Always open new buffer in another tab.
        " autocmd BufAdd,BufNewFile * nested tab sball

        " Autoread changes when file is modified externally.
        autocmd BufEnter,FocusGained $HOME/* checktime

        " Look into subdirectories when searching for files (only after home dir).
        autocmd BufEnter $HOME/*/* setlocal path+=**

        " Jump to last edit position when opening a file.
        autocmd BufReadPost * if expand("%:p") !~# "\m/\.git/" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    augroup END



    " Group all the commands that take care of redrawing or updating interface.
    augroup drawing
        autocmd!

        " Automatically rebalance panes on window resizing.
        autocmd VimResized * :wincmd = | redrawstatus!

        " Redraw statusline when entering Command mode.
        autocmd CmdlineEnter * redrawstatus!

        " When a new colorscheme is loaded, source statusline's config file to
        " update its colors.
        autocmd ColorScheme * :source $HOME/.config/nvim/lua/moonvim/plugins/lualine.lua
    augroup END



    " Group all the commands to execute pre/post buffer writing.
    augroup writing
        autocmd!

        " Remove trailing spaces and lines before saving (for all filetypes
        " except those in this blacklist).
        let blacklist_writing = ["md", "diff"]
        autocmd BufWritePre * if index(blacklist_writing, &ft) < 0 | :call RemoveTrailingSpacesAndLines() | endif

        " Formatting on save.
        "autocmd BufWritePre *.lua :silent lua vim.lsp.buf.format()

        " Source config files after saving them.
        autocmd BufWritePost *.vim,*.lua :so
        autocmd BufWritePost *tmux.conf :silent !tmux source-file %
        autocmd BufWritePost *Xresources,*Xdefaults :silent !xrdb %

        " Restart dunst notification daemon and send test notification.
        autocmd BufWritePost *dunstrc :silent !killall dunst &>/dev/null ; notify-send ciao
    augroup END



    " Use default line numbers in Insert mode and relative ones in every other mode.
    augroup numbers
        autocmd!
        " Do not perform this operation in the alpha dashboard.
        let blacklist_numbers = ["alpha"]
        autocmd InsertLeave * if index(blacklist_numbers, &ft) < 0 | :set relativenumber | endif
        autocmd InsertEnter * if index(blacklist_numbers, &ft) < 0 | :set norelativenumber | endif
    augroup END
]])


-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
    end,
})
