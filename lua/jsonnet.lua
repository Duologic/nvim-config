local utils = require('utils')

vim.g.jsonnet_command = 'jsonnet -J . -J vendor -J lib'
vim.g.jsonnet_string_command = 'jsonnet -S -J . -J vendor -J lib'

if os.getenv('JSONNET_BIN') ~= nil and os.getenv('JSONNET_BIN') ~= '' then
    vim.g.jsonnet_command = os.getenv('JSONNET_BIN') .. ' -J . -J vendor -J lib'
    vim.g.jsonnet_string_command = os.getenv('JSONNET_BIN') .. ' -S -J . -J vendor -J lib'
else
    local _ = vim.fn.system('tk tool jpath ' .. vim.fn.shellescape(vim.fn.expand('%')))
    if vim.api.nvim_get_vvar('shell_error') == 0 then
        vim.g.jsonnet_command = 'tk eval'
    end
end

vim.api.nvim_create_user_command(
    'JsonnetEval',
    function(opts)
        utils.RunCommand(vim.g.jsonnet_command, 'json', opts)
    end,
    { nargs = '?' })

vim.api.nvim_create_user_command(
    'JsonnetEvalString',
    function(opts)
        utils.RunCommand(vim.g.jsonnet_string_command, '', opts)
    end,
    { nargs = '?' })

vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = { 'jsonnet' },
        callback = function()
            vim.keymap.set('n', '<leader>j', '<cmd>JsonnetEval<cr>')
            vim.keymap.set('n', '<leader>k', '<cmd>JsonnetEvalString<cr>')
            vim.opt_local.foldlevelstart = 1
        end,
    })
