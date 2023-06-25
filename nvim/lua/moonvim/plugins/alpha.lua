local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local utils = require("moonvim.utils")



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


-- Set banner only if window height is enough
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
    -- dashboard.button("p", "  Projects", ":Telescope projects<CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
    -- dashboard.button("s", "  Packer Sync", ":PackerSync<CR>"),
    dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
}


dashboard.section.footer.val = utils.align_center({ width = 0 }, {
    "",
    "In the end the Shadow is only a small and passing thing:",
    "there is light and high beauty for ever beyond its reach."
}, 0.5)
dashboard.section.footer.opts.position = "center"

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)


-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nonumber norelativenumber
]])
