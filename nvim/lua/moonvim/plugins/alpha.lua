local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

-- Find lenght of longest line.
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

-- Align text to the center.
local function align_center(container, lines, alignment)
    local output = {}
    local max_len = max_len_line(lines)
    for _, line in ipairs(lines) do
        local padding = string.rep(" ", (math.max(container.width, max_len) - line:len()) * alignment)
        table.insert(output, padding .. line)
    end
    return output
end


local banner = {
    [[      ⠀⠀⠀⠀⠀⠀⠀⢀⡠⠔⠚⠉⠩⠍⠩⠍⢩⣶⣦⣤⡀⠀⠀⠀⠀⠀⠀      ]],
    [[      ⠀⠀⠀⠀⠀⡠⡲⠑⢈⣨⠵⠊⠁⠀⠀⠀⠈⠲⢌⡻⣿⣶⣄⡀⠀⠀⠀      ]],
    [[      ⠀⠀⠀⣠⡾⠊⠈⠉⠉⣑⣀⣀⠀⠀⠀⠀⠀⡶⢄⡈⢻⣿⠟⠻⣄⠀⠀      ]],
    [[      ⠀⠀⡐⡑⠁⢀⠏⢠⢞⠕⠚⠉⢻⣏⠀⠀⠀⠑⠀⢱⠀⠉⢇⠀⢹⣦⠀      ]],
    [[      ⠀⠰⣼⠀⠀⠀⢰⡎⠁⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠃⠀⠀⠈⠘⡟⢿⡇      ]],
    [[      ⠀⢷⡿⢰⠓⠀⠀⢣⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⠐⠀⢄⠄⠄⢣⣸⡿      ]],
    [[      ⠘⣸⠁⠸⠔⢀⡀⠀⠳⠦⢤⡶⠂⠀⠀⠀⠀⠀⠀⠀⠀⡀⠣⡆⠀⣿⣿      ]],
    [[      ⠀⣿⠀⠀⠀⠈⠁⠀⠀⠀⠀⠓⠀⠀⠀⠀⠀⠀⠀⠐⠁⠀⣀⢀⠿⢿⣿      ]],
    [[      ⠀⠸⡇⢀⠀⠀⡀⠀⠀⠀⠀⢄⠀⠀⠀⡄⠀⠀⠀⠀⢀⡞⢁⠄⠀⣼⡇      ]],
    [[      ⠀⠀⠻⡌⢆⠰⡠⠐⠈⠀⣤⠜⠒⢢⠀⠀⠀⠢⠄⢀⣈⣄⢾⢴⡿⡟⠀      ]],
    [[      ⠀⠀⠀⠹⣌⡿⢄⠀⠀⠀⠣⣄⢀⠶⠃⠀⢀⣀⣀⣤⣿⢿⣶⣯⠊⠀⠀      ]],
    [[      ⠀⠀⠀⠀⠈⠛⢷⣝⡢⢔⡀⠈⠂⠤⠤⠀⢉⣹⠿⣫⣴⡿⠛⠁⠀⠀⠀      ]],
    [[      ⠀⠀⠀⠀⠀⠀⠀⠉⠛⠲⠤⣷⣦⣶⣶⣞⣛⠛⠿⠛⠋⠀⠀⠀⠀⠀⠀      ]],
    [[                                       ]],
}

local banner_small = {
    [[ █▀▄▀█ █▀█ █▀█ █▄░█ █░█ █ █▀▄▀█  ]],
    [[ █░▀░█ █▄█ █▄█ █░▀█ ▀▄▀ █ █░▀░█  ]],
}


local dashboard = require("alpha.themes.dashboard")

-- Choose banner based on window height.
dashboard.section.header.val = function()
    local alpha_wins = vim.tbl_filter(
        function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            return vim.api.nvim_buf_get_option(buf, "filetype") == "alpha"
        end,
        vim.api.nvim_list_wins()
    )

    if vim.api.nvim_win_get_height(alpha_wins[#alpha_wins]) < 35 then
        return banner_small
    end
    return banner
end


dashboard.section.buttons.val = {
    dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "  Find file", ":lua require'moonvim.utils'.find_files()<CR>"),
    dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
}


dashboard.section.footer.val = align_center({ width = 0 }, {
    "",
    "Moonlight drowns out all but the brightest stars.",
}, 0.5)
dashboard.section.footer.opts.position = "center"

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)


-- Disable line numbers in alpha buffer.
vim.cmd([[
    autocmd FileType alpha setlocal nonumber norelativenumber
]])
