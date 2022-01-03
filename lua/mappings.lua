--- Ensure search results appear in the middle of the screen
vim.cmd([[
    nnoremap n nzz
    nnoremap N Nzz
    nnoremap * *zz
    nnoremap # #zz
    nnoremap g* g*zz
    nnoremap g# g#zz
]])

--- Open URIs with the appropriate application
vim.cmd([[
    nnoremap gx :!xdg-open <cWORD> &<cr><cr>
]])
