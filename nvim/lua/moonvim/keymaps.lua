local utils = require("moonvim.utils")

local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap
local inoremap = utils.inoremap


-- Mapping delay.
vim.opt.timeoutlen = 500
-- Key code delay (0 so that pressing O will create a new line immediately)
vim.opt.ttimeoutlen = 0



--------------------------------------------------------------------------------
----- GENERAL
--------------------------------------------------------------------------------

-- :Reload to source these configuration files.
vim.cmd [[
    command! Reload execute 'source ~/.config/nvim/init.lua'
]]
-- Ctrl+r  to reload.
nnoremap("<C-r>", ":Reload<CR>")
-- Ctrl+y  to redo last change.
nnoremap("<C-y>", ":redo<CR>")
-- U       to redo last change.
nnoremap("U", ":redo<CR>")

-- Esc+s  to toggle spell check.
nnoremap("<Esc>s", ":setlocal spell!<CR>")

-- Undo break points. (if I undo with 'u' in Normal mode, it will only undo the
-- insertion up to the last , or . ...)
inoremap(",", ",<c-g>u")
inoremap(".", ".<c-g>u")
inoremap("!", "!<c-g>u")
inoremap("?", "?<c-g>u")

-- command :Q behaves like :q
-- command :W behaves like :w
vim.cmd [[
    command! Q execute 'q'
    command! W execute 'w'
]]

-- Ctrl+\ to open file navigation
nnoremap("<C-\\>", ":silent Neotree toggle<CR>")

-- Disable command history
nnoremap("q:", "<nop>")



--------------------------------------------------------------------------------
----- COPY & PASTE
--------------------------------------------------------------------------------

-- Use CTRL+C to copy to system clipboard.
vnoremap("<C-c>", "\"+y")
nnoremap("<C-c>", "v\"+y")

-- Paste without overwriting yanked text.
vnoremap("p", "\"_dP")
-- Delete character without overwriting yanked text.
nnoremap("x", "\"_x")

-- CTRL+A to select entire document.
nnoremap("<C-a>", "gg<S-v>G")

-- CTRL+H to search and replace.
nnoremap("<C-h>", ":%s/")
-- CTRL+H in visual mode to search and replace selection.
vnoremap("<C-h>", "\"hy:%s/<C-r>h//g<left><left>")



--------------------------------------------------------------------------------
----- MOVEMENT
--------------------------------------------------------------------------------

-- Disable space in normal mode (it would go to next character).
nnoremap("<Space>", "<NOP>")

-- Disable arrow keys for cursor navigation in NORMAL, VISUAL and INSERT mode.
nnoremap("<Left>", "<NOP>")
vnoremap("<Left>", "<NOP>")
inoremap("<Left>", "<NOP>")
nnoremap("<Down>", "<NOP>")
vnoremap("<Down>", "<NOP>")
inoremap("<Down>", "<NOP>")
nnoremap("<Up>", "<NOP>")
vnoremap("<Up>", "<NOP>")
inoremap("<Up>", "<NOP>")
nnoremap("<Right>", "<NOP>")
vnoremap("<Right>", "<NOP>")
inoremap("<Right>", "<NOP>")

-- Move up and down by visual line (even lines that are actually wraps).
nnoremap("k", "gk")
nnoremap("j", "gj")

-- Keep cursor centered while moving up and down.
nnoremap("G", "Gzz")
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
nnoremap("}", "}zz")
nnoremap("{", "{zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("J", "mzJ`z")

-- Better indenting.
vnoremap("<", "<gv")
vnoremap(">", ">gv")



--------------------------------------------------------------------------------
----- PANES
--------------------------------------------------------------------------------

-- arrowkeys focuses another pane without having to press CTRL+w.
nnoremap("<Left>", ":wincmd h<CR>")
nnoremap("<Down>", ":wincmd j<CR>")
nnoremap("<Up>", ":wincmd k<CR>")
nnoremap("<Right>", ":wincmd l<CR>")

-- Esc+arrowkeys will increase/decrease space for current pane.
nnoremap("<Esc><Left>", ":vertical resize -5<CR>")
nnoremap("<Esc><Down>", ":resize -5<CR>")
nnoremap("<Esc><Right>", ":vertical resize +5<CR>")
nnoremap("<Esc><Up>", ":resize +5<CR>")
-- = will reset split size view.
nnoremap("=", "<C-w>=")



--------------------------------------------------------------------------------
----- BUFFERS
--------------------------------------------------------------------------------

-- Use TAB to cycle through open buffers.
nnoremap("<Tab>", ":bnext<CR>")
nnoremap("<S-Tab>", ":bprevious<CR>")
nnoremap("gn", ":bnext<CR>")
nnoremap("gp", ":bprevious<CR>")



--------------------------------------------------------------------------------
----- TABS
--------------------------------------------------------------------------------

nnoremap("<C-n>", ":tabnew<CR>")
nnoremap("<C-q>", ":tabclose<CR>")
nnoremap("<C-Left>", ":tabprevious<CR>")
nnoremap("<C-Right>", ":tabnext<CR>")



--------------------------------------------------------------------------------
----- NERDCommenter
--------------------------------------------------------------------------------

-- CTRL + 7  or  CTRL + SHIFT + 7
nnoremap("<C-_>", ":call nerdcommenter#Comment('n', 'Toggle')<CR>")
vnoremap("<C-_>", ":call nerdcommenter#Comment('x', 'Toggle')<CR>")



--------------------------------------------------------------------------------
----- FUZZY FINDER
--------------------------------------------------------------------------------

nnoremap("<space><space>", ":Telescope<CR>")
nnoremap("<C-o>", utils.find_files)
nnoremap("<C-b>", ":Telescope buffers<CR>")
nnoremap("<C-t>", ":Telescope live_grep<CR>")
nnoremap("<space>sb", ":Telescope buffers<CR>")
nnoremap("<space>sc", ":Telescope colorscheme<CR>")
nnoremap("<space>sf", utils.find_files)
nnoremap("<space>sk", ":Telescope keymaps<CR>")
nnoremap("<space>sr", ":Telescope oldfiles<CR>")
nnoremap("<space>st", ":Telescope live_grep<CR>")
