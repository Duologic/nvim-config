vim.cmd([[
    map <leader>j :JsonnetEval<cr>
    map <leader>k :JsonnetEvalString<cr>

    autocmd FileType jsonnet setlocal foldmethod=syntax
    autocmd FileType jsonnet setlocal foldlevelstart=1

    let output = system("tk tool jpath " . shellescape(expand('%')))
    if v:shell_error
      let g:jsonnet_command='jsonnet -J . -J vendor -J lib '
    else
      let g:jsonnet_command='tk eval'
    endif

    " Evaluate jsonnet into vsplit, manifest as plain text
    function! JsonnetEvalString()
      let output = system('jsonnet -S -J . -J vendor -J lib ' . shellescape(expand('%')))
      vnew
      setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile ft=jsonnet
      put! = output
    endfunction

    command! -nargs=0 JsonnetEvalString call JsonnetEvalString()
]])
