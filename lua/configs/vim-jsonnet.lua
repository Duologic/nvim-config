-- Purposefully in vimscript for easier upstream contribution
vim.cmd([[
    function! ChooseBuffer(buffername)
       let bnr = bufwinnr(a:buffername)
       if bnr > 0
          :exe bnr . "wincmd w"
       else
          silent execute 'vsplit ' . a:buffername
       endif
    endfunction

    let g:jsonnet_reuse_buffer = 0
    let g:jsonnet_string_command = 'jsonnet -S -J . -J vendor -J lib'

    " Evaluate jsonnet into vsplit
    function! JsonnetEval()
      let output = system(g:jsonnet_command . ' ' . shellescape(expand('%')))
      if g:jsonnet_reuse_buffer != 0
        call ChooseBuffer(g:jsonnet_command)
      else
        vnew
      endif
      setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile ft=jsonnet
      :%delete _
      call setline(1, split(output, '\n'))
    endfunction

    " Evaluate jsonnet into vsplit, manifest as plain text
    function! JsonnetEvalString()
      let output = system(g:jsonnet_string_command . ' ' . shellescape(expand('%')))
      if g:jsonnet_reuse_buffer != 0
        call ChooseBuffer(g:jsonnet_string_command)
      else
        vnew
      endif
      setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile ft=jsonnet
      :%delete _
      call setline(1, split(output, '\n'))
    endfunction
]])

vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = { 'jsonnet' },
        callback = function()
            vim.opt_local.foldmethod = 'syntax'
            vim.opt_local.foldlevelstart = 1
        end,
    }
)

if os.getenv('JSONNET_BIN') ~= nil and os.getenv('JSONNET_BIN') ~= '' then
    vim.g.jsonnet_command = os.getenv('JSONNET_BIN') .. ' -J . -J vendor -J lib'
    vim.g.jsonnet_string_command = os.getenv('JSONNET_BIN') .. ' -S -J . -J vendor -J lib'
else
    local output = vim.fn.system('tk tool jpath ' .. vim.fn.shellescape(vim.fn.expand('%')))
    if vim.api.nvim_get_vvar('shell_error') ~= nil and vim.api.nvim_get_vvar('shell_error') ~= 0 then
        vim.g.jsonnet_command = 'jsonnet -J . -J vendor -J lib'
    else
        vim.g.jsonnet_command = 'tk eval'
    end
end

vim.g.jsonnet_reuse_buffer = 1
vim.g.jsonnet_fmt_on_save = 0 -- handled by LSP

vim.api.nvim_create_user_command('JsonnetEval', 'call JsonnetEval()', {})
vim.api.nvim_create_user_command('JsonnetEvalString', 'call JsonnetEvalString()', {})

vim.keymap.set('n', '<leader>j', '<cmd>JsonnetEval<cr>')
vim.keymap.set('n', '<leader>k', '<cmd>JsonnetEvalString<cr>')
