local theme

-- Find theme file based on current colorscheme.
local theme_name = require("moonvim.colorscheme")
local path = table.concat { 'colors/lualine/', theme_name, '.lua' }
local files = vim.api.nvim_get_runtime_file(path, true)
local n_files = #files

-- If there are no available theme files then disable all sections of the
-- statusline so that it does not appear.
if n_files <= 0 then
    require('lualine').setup({
        sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        }
    })
    return

-- Load theme from file.
elseif n_files == 1 then
    theme = dofile(files[1])
end



-- Show if any macro is being recorded.
local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "REC @" .. recording_register
    end
end



require('lualine').setup({
    options = {
        theme = theme,
        icons_enabled = true,
        globalstatus = true, -- all panes share the same statusline.
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
        disabled_filetypes = {
            statusline = {
                "alpha",
                "TelescopePrompt"
            },
        },
        section_separators = "",
        component_separators = "|",
    },

    sections = {
        lualine_a = {
            "mode",
        },
        lualine_b = {
            "branch",
            -- {
                -- "diff",
                -- colored = false,
                -- diff_color = {
                    -- added    = 'DiffAdd',
                    -- modified = 'DiffChange',
                    -- removed  = 'DiffDelete',
                -- },
                -- symbols = { added = '+', modified = '~', removed = '-' },
            -- },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn", "info" },
            },
            {
                "macro_recording",
                fmt = show_macro_recording,
            },
        },
        lualine_c = {
            {
                "filename",
                file_status = true, -- readonly, modified, ...
                newfile_status = true,
                path = 4,
            },
        },
        lualine_x = {
            "encoding",
            "fileformat",
            "filetype",
        },
        lualine_y = {
        },
        lualine_z = {
            "location",
        },
    }
})
