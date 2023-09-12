require('aerial').setup({
    filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',

        'Field',    -- For jsonnet
        'Variable', -- For jsonnet
    },
    icons = {
        Class = '󰠱',
        Color = '󰏘',
        Constant = '󰏿',
        Constructor = '',
        Enum = '',
        EnumMember = '',
        Event = '',
        Field = '󰜢',
        File = '󰈙',
        Folder = '󰉋',
        Function = '󰊕',
        Interface = '',
        Keyword = '󰌋',
        Method = '󰆧',
        Module = '',
        Operator = '󰆕',
        Property = '󰜢',
        Reference = '󰈇',
        Snippet = '',
        Struct = '󰙅',
        Text = '󰉿',
        TypeParameter = '',
        Unit = '󰑭',
        Value = '󰎠',
        Variable = '󰀫',
    },

    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
    end
})

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
