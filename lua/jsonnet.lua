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

vim.api.nvim_create_user_command(
    'JsonnetFmt',
    function(opts)
        if opts.range == 0 then
            vim.lsp.buf.format()
            return
        end
        local line1 = vim.api.nvim_buf_get_mark(0, '<')[1]
        local line2 = vim.api.nvim_buf_get_mark(0, '>')[1]
        local selection = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, true)

        local bufnr = vim.fn.bufadd('temp.jsonnet')
        vim.api.nvim_buf_set_option(bufnr, 'filetype', 'jsonnet')
        require('lspconfig.configs')['jsonnet_ls'].launch(bufnr)
        --vim.lsp.buf_attach_client(bufnr, 1)

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, selection)
        vim.api.nvim_buf_set_option(bufnr, 'buflisted', true)
        --vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
        --vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
        --vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)

        vim.lsp.buf.format({ bufnr = bufnr })
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
        --print(vim.inspect(lines))
        vim.api.nvim_buf_set_lines(
            0, line1 - 1, line2, true,
            lines
        )
    end,
    { range = true })

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
