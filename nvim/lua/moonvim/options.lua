--------------------------------------------------------------------------------
---- GENERAL
--------------------------------------------------------------------------------

vim.opt.viminfo:append('n~/.cache/nviminfo')

vim.opt.shortmess:append("IastWF")

vim.opt.updatetime = 100

vim.opt.spell = false



--------------------------------------------------------------------------------
---- EDITOR BEHAVIOUR
--------------------------------------------------------------------------------

-- Only enable mouse usage in specific modes.
vim.opt.mouse = "nh"

-- Hide mouse pointer when any key is pressed.
vim.opt.mousehide = true

-- Disable folding when opening a file, it can be restored with zc.
vim.opt.foldenable = false

-- Always add new pane to the right and to the bottom.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Fix some backspace problems.
vim.opt.backspace = "indent,eol,start"

-- Speedup scrolling and typing responsiveness.
vim.opt.ttyfast = true

-- Do not redraw while executing macros.
vim.opt.lazyredraw = true

-- Jump briefly to matching bracket when writing.
vim.opt.showmatch = true
-- Tenths of a second to spend on the other bracket.
vim.opt.mat = 2

-- Start scrolling entire page when cursor reaches N lines from the top/bottom.
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5

-- Yanking also saves in system clipboard.
vim.opt.clipboard:append("unnamedplus")



--------------------------------------------------------------------------------
---- SEARCH
--------------------------------------------------------------------------------

-- Do not highlight search matches.
vim.opt.hlsearch = false

-- Find results while typing.
vim.opt.incsearch = true

-- Ignore case during search.
vim.opt.ignorecase = true

-- Override ignorecase if searching for Capital Letters.
vim.opt.smartcase = true

-- Add the 'g' flag (replace all) to default for the :%s command.
vim.opt.gdefault = true

-- Do not show preview of command in split window.
vim.opt.inccommand = "nosplit"



--------------------------------------------------------------------------------
---- TABS, SPACES, INDENTATION
--------------------------------------------------------------------------------

-- Enable auto indentation.
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Use spaces instead of tabs.
vim.opt.expandtab = true

-- How many spaces a level of indentation is.
vim.opt.shiftwidth = 4

-- How many spaces a \t is.
vim.opt.tabstop = 4

-- How many spaces a TAB or BACKSPACE keypress is.
vim.opt.softtabstop = 4

-- Wrap longer lines.
vim.opt.wrap = true
-- Linebreak on 80 characters.
vim.opt.linebreak = true
-- Characters to print showing that a line has been wrapped.
vim.opt.showbreak = ''

-- Lines longer than this will be split at the first whitespace.
vim.opt.textwidth = 80

-- To automatically comment or follow paragraph indentation,...
vim.opt.formatoptions:append("jtql2n")



--------------------------------------------------------------------------------
----- APPEARANCE
--------------------------------------------------------------------------------

-- Show relative line numbers (except for the current line which follows global
-- enumeration).
vim.opt.number = true
vim.opt.relativenumber = true

-- Use block cursor also in INSERT mode.
--vim.opt.guicursor = "i:block"

-- Add extra margin to the left.
vim.opt.signcolumn = "yes"

-- Highlight current line.
vim.opt.cursorline = false

-- Display different kinds of white spaces.
vim.opt.list = true
vim.opt.listchars = {
    tab = "› ",
    trail = "•",
    extends = "#",
    nbsp = ".",
}

-- Keep transparent background.
vim.cmd([[
    highlight Normal  guibg=none
    highlight Normal  ctermbg=none
    highlight NonText guibg=none
    highlight NonText ctermbg=none
]])

-- vim.opt.ruler at 80 characters.
vim.opt.colorcolumn = ""



--------------------------------------------------------------------------------
----- COMMAND-LINE
--------------------------------------------------------------------------------

-- Height of the command-line bar.
vim.opt.cmdheight = 0

-- Declutter command-line.
vim.opt.showmode = false
vim.opt.showcmd = false

-- Commands' history size.
vim.opt.history = 50



--------------------------------------------------------------------------------
----- FILES, BUFFERS, DIRECTORIES
--------------------------------------------------------------------------------

-- Ask for confirmation if leaving unsaved document.
vim.opt.confirm = true

-- Automatically cd into the folder of current buffer.
vim.opt.autochdir = true

-- Enable auto completion when pressing TAB in command-line.
vim.opt.wildmenu = true
vim.opt.wildmode = "longest,list,full"

-- Ignore this files during auto completion.
vim.opt.wildignore = "*.jpg,*.png,*.gif,*.pdf,*/*.out,*/*.o,*/*.class,*/.git/*,*/.DS_Store"

-- Paths in which to look for files during :find command.
vim.opt.path:remove "/usr/include"

-- Add include path for autocomplete suggestions.
vim.opt.complete:append("i")

-- Default encoding.
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"
