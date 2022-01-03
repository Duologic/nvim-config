vim.cmd([[
    colorscheme NeoSolarized
    let g:solarized_contrast="high"
    let g:solarized_visibility="low"
]])

--- NOTE: truecolor terms will use guibg
vim.highlight.create('LineNr', {ctermbg=230, guibg='#FFF8DD'}, false)
vim.highlight.create('CursorLine', {cterm='NONE', ctermbg='lightyellow', guibg='lightyellow'}, false)
vim.highlight.create('CursorLineNr', {ctermbg='lightyellow', guibg='lightyellow'}, false)
vim.highlight.create('ColorColumn', {ctermbg=231, guibg='white'}, false)
