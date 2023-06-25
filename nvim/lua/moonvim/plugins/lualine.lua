local theme

-- Load theme based on current colorscheme.
-- Use 'auto' theme as fallback.
local theme_name = require("moonvim.colorscheme")
local path = table.concat { 'colors/lualine/', theme_name, '.lua' }
local files = vim.api.nvim_get_runtime_file(path, true)
local n_files = #files
if n_files <= 0 then
    theme = "auto"
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
        globalstatus = true, -- if true every split has its own.
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
            -- colored = true, -- Displays a colored diff status if set to true
            -- diff_color = {
            -- -- Same color values as the general color option can be used here.
            -- added    = 'DiffAdd',    -- Changes the diff's added color
            -- modified = 'DiffChange', -- Changes the diff's modified color
            -- removed  = 'DiffDelete', -- Changes the diff's removed color you
            -- },
            -- symbols = {added = '+', modified = '~', removed = '-'},
            -- },
            -- {
            -- "diagnostics",
            -- sources = {"nvim_diagnostic"},
            -- sections = {"error", "warn", "info"},
            -- },
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
