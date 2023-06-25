local colors = {}


if vim.go.background == "dark" then
    colors.bg = "#262626"
    colors.bg2 = "#383838"
    colors.fg = "#FFFFFF"
    colors.light_fg = "#FFFFFF"
    colors.normal = "#0078D4"
    colors.insert = "#7FB785"
    colors.visual = "#DCDCAA"
    colors.replace = "#F44747"
    colors.inactive = "#666666"
else
    colors.bg = "#FFFFFF"
    colors.bg2 = "#d8d8d8"
    colors.fg = "#343434"
    colors.light_fg = "#343434"
    colors.normal = "#005FB8"
    colors.insert = "#7FB785"
    colors.visual = "#DCDCAA"
    colors.replace = "#FF0000"
    colors.inactive = "#666666"
end


local theme = {
    normal = {
        a = {
            fg = vim.go.background == "dark" and colors.fg or colors.bg,
            bg = colors.normal,
            gui = "bold"
        },
        b = {
            fg = colors.light_fg,
            bg = colors.bg2,
        },
        c = {
            fg = colors.fg,
            --bg = colors.bg,
        },
        z = {
            fg = vim.go.background == "dark" and colors.fg or colors.bg,
            bg = colors.normal,
        },
    },

    replace = {
        a = {
                fg = vim.go.background == "dark" and colors.fg or colors.bg,
                bg = colors.replace,
                gui = "bold",
        },
        b = {
                fg = colors.light_fg,
                bg = colors.bg2,
        },
        z = {
            fg = vim.go.background == "dark" and colors.fg or colors.bg,
            bg = colors.replace,
        },
    },

    insert = {
        a = {
                fg = vim.go.background == "dark" and colors.bg or colors.fg,
                bg = colors.insert,
                gui = "bold",
        },
        b = {
                fg = colors.light_fg,
                bg = colors.bg2,
        },
        z = {
            fg = vim.go.background == "dark" and colors.bg or colors.fg,
            bg = colors.insert,
        },
    },

    visual = {
        a = {
                fg = vim.go.background == "dark" and colors.bg or colors.fg,
                bg = colors.visual,
                gui = "bold",
        },
        b = {
                fg = colors.light_fg,
                bg = colors.bg2,
        },
        z = {
            fg = vim.go.background == "dark" and colors.bg or colors.fg,
            bg = colors.visual,
        },
    },

    inactive = {
        a = {
                fg = colors.inactive,
                bg = colors.bg,
        },
        b = {
                fg = colors.inactive,
                bg = colors.bg,
        },
        c = {
                fg = colors.inactive,
                --bg = colors.bg,
        },
    },
}

return theme
