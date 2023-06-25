set background=dark

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let g:colors_name = "wombat"

set notermguicolors

" Transparent background.
"hi Normal ctermfg=none ctermbg=none

" General colors
hi Normal          ctermfg=252    ctermbg=none    cterm=none
hi NonText         ctermfg=252    ctermbg=none    cterm=none
hi Cursor          ctermfg=234    ctermbg=228     cterm=none
hi Visual          ctermfg=251    ctermbg=239     cterm=none
hi VisualNOS       ctermfg=251    ctermbg=236     cterm=none
hi Search          ctermfg=0      ctermbg=107     cterm=none
hi Folded          ctermfg=103    ctermbg=237     cterm=none
hi Title           ctermfg=230                    cterm=bold
hi VertSplit       ctermfg=238    ctermbg=238     cterm=none
hi LineNr          ctermfg=244
hi CursorLineNr    ctermfg=248                    cterm=bold
" Mostra caratteri speciali tipo CTRL+z.
hi SpecialKey      ctermfg=241    ctermbg=235     cterm=none
" Mostra i caratteri extra tipo nspb, tab, eof.
hi NonText         ctermfg=240    ctermbg=none    cterm=none
hi WarningMsg      ctermfg=203
hi ErrorMsg        ctermfg=196    ctermbg=236     cterm=bold
hi ColorColumn                    ctermbg=236

if version >= 700
    hi CursorLine                 ctermbg=236     cterm=none
    hi MatchParen  ctermfg=228    ctermbg=101     cterm=bold
    " Colors for autocompletion like cmp or lsp
    hi Pmenu       ctermfg=252    ctermbg=238
    hi PmenuSel    ctermfg=0      ctermbg=110
    " Scrollbar handle.
    hi PmenuThumb                 ctermbg=245
    " Scrollbar empty section.
    hi PmenuSbar                  ctermbg=238
endif

" Diff highlighting
hi DiffAdd                        ctermbg=17
hi DiffDelete      ctermfg=234    ctermbg=60      cterm=none
hi DiffText                       ctermbg=53      cterm=none
hi DiffChange                     ctermbg=237

" Syntax highlighting
hi Keyword         ctermfg=111    cterm=none
hi Statement       ctermfg=111    cterm=none
hi Constant        ctermfg=173    cterm=none
hi Number          ctermfg=173    cterm=none
hi PreProc         ctermfg=173    cterm=none
hi Function        ctermfg=192    cterm=none
hi Identifier      ctermfg=192    cterm=none
hi Type            ctermfg=186    cterm=none
hi Special         ctermfg=229    cterm=none
hi String          ctermfg=113    cterm=none
" Make comments italic by changing cterm
hi Comment         ctermfg=246    cterm=none

" Spelling
hi SpellBad        ctermfg=174    ctermbg=none    cterm=underline,italic,bold
hi SpellLocal      ctermfg=174    ctermbg=none    cterm=underline,italic,bold
hi SpellRare       ctermfg=174    ctermbg=none    cterm=underline,italic,bold
hi SpellCap        ctermfg=174    ctermbg=none    cterm=underline,italic,bold

" Status Line
hi StatusLine      ctermfg=252    ctermbg=238     cterm=none
hi StatusLineNC    ctermfg=245    ctermbg=235     cterm=none
hi StatusNormal    ctermfg=236    ctermbg=110     cterm=bold
hi StatusInsert    ctermfg=236    ctermbg=107     cterm=bold
hi StatusVisual    ctermfg=236    ctermbg=180     cterm=bold
hi StatusCommand   ctermfg=236    ctermbg=140     cterm=bold
hi StatusReplace   ctermfg=236    ctermbg=174     cterm=bold
hi StatusTerminal  ctermfg=235    ctermbg=110     cterm=bold
hi StatusPosition  ctermfg=252    ctermbg=242
hi StatusGit       ctermfg=252    ctermbg=242
hi StatusFlags     ctermfg=110    ctermbg=236

" SignColumn = Column left of line numbers
hi SignColumn                     ctermbg=none

" Git Gutter symbols.
hi GitGutterAdd          ctermfg=113   ctermbg=none  cterm=bold
hi GitGutterChange       ctermfg=110   ctermbg=none  cterm=bold
hi GitGutterDelete       ctermfg=174   ctermbg=none  cterm=bold
hi GitGutterChangeDelete ctermfg=174   ctermbg=none  cterm=bold

" Top Tab bar.
hi TabLineSel      ctermfg=252    ctermbg=240
hi TabLine         ctermfg=252    ctermbg=238 cterm=none
hi TabLineFill     ctermfg=238



"hi CursorIM
"hi Directory
"hi IncSearch
"hi Todo
"hi Menu
"hi ModeMsg
"hi MoreMsg
"hi Question
"hi Scrollbar
"hi Tooltip
"hi User1
"hi User9
"hi WildMenu
