local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require("telescope.actions")

telescope.setup {
    initial_mode = "insert",
    selection_strategy = "reset",

    defaults = {
        path_display = { "smart" },
        winblend = 0,
        border = {},
        borderchars = nil,
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },

        mappings = {
            i = {
                ["<ESC>"] = actions.close
            }
        },
    },

    pickers = {
        find_files = {
            hidden = true,
            theme = "ivy",
            -- previewer = false,
        },
        git_files = {
            hidden = true,
            show_untracked = true,
            theme = "ivy",
            -- previewer = false,
        },
        oldfiles = {
            theme = "ivy",
            -- previewer = false,
        },
        buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer,
                },
                n = {
                    ["dd"] = actions.delete_buffer,
                },
            },
        },
        live_grep = {
            theme = "ivy",
        },
        colorscheme = {
            enable_preview = true,
        },
    },
}
