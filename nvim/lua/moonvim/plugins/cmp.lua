local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    return
end

vim.opt.pumheight = 10


-- Icons to use for different suggestion types.
local cmp_kinds = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = 'λ  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
}


cmp.setup {
    view = {
        entries = { name = "custom", selection_order = "near_cursor" }
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        -- Ctrl+Space to toggle completion
        ['<C-Space>'] = function(fallback)
            if cmp.visible() then
                cmp.close()
            else
                cmp.complete()
            end
        end,

        ["<C-n>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        -- Close autosuggestions
        ["<C-e>"] = cmp.mapping.abort(),

        -- map TAB to confirm current (or first) suggestion.
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),

        -- Scroll documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = 'luasnip' },
        { name = 'path' },
        { name = "buffer",  keyword_length = 5 },
        { name = "spell",   keyword_length = 5 },
    }),

    formatting = {
        fields = { "abbr", "kind" },
        format = function(_, vim_item)
            vim_item.kind = cmp_kinds[vim_item.kind] or ""
            return vim_item
        end
    },

    sorting = {
        comparators = {
            cmp.config.compare.kind,
            cmp.config.compare.offset,
            cmp.config.compare.length,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.sort_text,
            cmp.config.compare.order
        },
    },

    completion = {
        -- menuone:  popup menu even if there is only one match.
        -- noinsert: do not insert text until a selection is made.
        completeopt = 'menu,menuone,noinsert'
    },
}


-- Use buffer source for '/'
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    })
})


--  Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
