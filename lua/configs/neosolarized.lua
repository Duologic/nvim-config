vim.cmd.colorscheme('NeoSolarized')
vim.g.solarized_contrast = 'high'
vim.g.solarized_visibility = 'low'

--- NOTE: truecolor terms will use guibg
vim.api.nvim_set_hl(
    'LineNr',
    {
        ctermbg = 230,
        guibg = '#FFF8DD'
    },
    false
)
vim.api.nvim_set_hl(
    'CursorLine',
    {
        cterm = 'NONE',
        ctermbg = 'lightyellow',
        guibg = 'lightyellow'
    },
    false
)
vim.api.nvim_set_hl(
    'CursorLineNr',
    {
        ctermbg = 'lightyellow',
        guibg = 'lightyellow'
    },
    false
)
vim.api.nvim_set_hl(
    'ColorColumn',
    {
        ctermbg = 231,
        guibg = 'white'
    },
    false
)
