local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
    return
end

neotree.setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = false,
    enable_diagnostics = true,

    default_component_configs = {
        indent = {
            indent_size = 2,
            padding = 0,
            with_markers = false,
            highlight = "NeoTreeIndentMarker"
        },
        name = {
            trailing_slash = true,
            use_git_status_colors = false,
            highlight = "NeoTreeFileName"
        },
    },

    -- Define custom functions.
    commands = {
        parent_or_close = function(state)
            local node = state.tree:get_node()
            if (node.type == "directory" or node:has_children()) then
                if node:is_expanded() then
                    state.commands.toggle_node(state)
                else
                    state.commands.navigate_up(state)
                end
            else
                require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
        end,
        child_or_open = function(state)
            local node = state.tree:get_node()
            if (node.type == "directory" or node:has_children()) then
                if not node:is_expanded() then
                    state.commands.toggle_node(state)
                else
                    require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                end
            else
                state.commands.open_tabnew(state)
            end
        end
    },

    window = {
        position = "left",
        width = 30,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<CR>"] = "open_drop",
            ["H"] = "toggle_hidden",
            ["h"] = "parent_or_close",
            ["l"] = "child_or_open",
            ["o"] = "open_tabnew",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["d"] = "delete",
            ["r"] = "rename",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<bs>"] = "navigate_up",
        }
    },

    filesystem = {
        filtered_items = {
            visible = false,
            hide_gitignored = true,
            hide_by_pattern = {
                "*/__pycache__/",
            },
        },
        follow_current_file = true,
        group_empty_dirs = true,
    },
})
