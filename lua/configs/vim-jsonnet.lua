vim.cmd([[
    map <leader>j :call jsonnet#JsonnetEval()<cr> 
    autocmd FileType jsonnet setlocal foldmethod=syntax
    autocmd FileType jsonnet setlocal foldlevelstart=1
]])
