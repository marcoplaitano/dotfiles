local M = {}



--- Toggle background="dark"|"light"
function M.toggle_background()
    vim.go.background = vim.go.background == "light" and "dark" or "light"
end



--------------------------------------------------------------------------------
-----  KEY REMAPPING
--------------------------------------------------------------------------------

function M.map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {silent =  true})
end

function M.noremap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {noremap = true, silent = true})
end

function M.exprnoremap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {noremap = true, silent = true, expr = true})
end

function M.nmap(lhs, rhs) M.map('n', lhs, rhs) end

function M.xmap(lhs, rhs) M.map('x', lhs, rhs) end

function M.nnoremap(lhs, rhs) M.noremap('n', lhs, rhs) end

function M.vnoremap(lhs, rhs) M.noremap('v', lhs, rhs) end

function M.xnoremap(lhs, rhs) M.noremap('x', lhs, rhs) end

function M.inoremap(lhs, rhs) M.noremap('i', lhs, rhs) end

function M.tnoremap(lhs, rhs) M.noremap('t', lhs, rhs) end

function M.exprnnoremap(lhs, rhs) M.exprnoremap('n', lhs, rhs) end

function M.exprinoremap(lhs, rhs) M.exprnoremap('i', lhs, rhs) end



--------------------------------------------------------------------------------
-----  FUZZY FINDING
--------------------------------------------------------------------------------

function M.find_files()
    local _, builtin = pcall(require, "telescope.builtin")
    -- Try looking for git files, if that fails look through all files.
    local ok = pcall(builtin.git_files, {})
    if not ok then
        builtin.find_files({})
    end
end


local function max_len_line(lines)
    local max_len = 0
    for _, line in ipairs(lines) do
        local line_len = line:len()
        if line_len > max_len then
            max_len = line_len
        end
    end
    return max_len
end
-- Align text to the center. Used by alpha.
function M.align_center(container, lines, alignment)
    local output = {}
    local max_len = max_len_line(lines)
    for _, line in ipairs(lines) do
        local padding = string.rep(" ", (math.max(container.width, max_len) - line:len()) * alignment)
        table.insert(output, padding .. line)
    end
    return output
end



return M
