local function splitlines(str)
    local result = {};
    for line in string.gmatch(str .. '\n', '(.-)\n') do
        table.insert(result, line);
    end
    return result
end

local function getBuffer(name, filetype, opts)
    local bufnr = vim.fn.bufnr(name)
    if bufnr == -1 then
        bufnr = vim.fn.bufadd(name)
        vim.fn.win_execute(vim.fn.win_getid(1), string.format('%s sbuffer %d', opts.mods, bufnr))
        vim.api.nvim_buf_set_option(bufnr, 'buflisted', false)
        vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
        vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
        vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)
        vim.api.nvim_buf_set_option(bufnr, 'filetype', filetype or '')
    end
    return bufnr
end

local function run_command(cmd, filetype, opts)
    local stdout = vim.fn.system(cmd .. ' ' .. vim.fn.shellescape(vim.fn.expand('%')))
    local stderr = vim.api.nvim_get_vvar('shell_error')
    if stderr == 0 then
        local bufnr = getBuffer(cmd, filetype, opts)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, splitlines(stdout))
    else
        vim.notify(
            ('cmd (%q) failed:\n%s'):format(cmd, stdout),
            vim.log.levels.WARN
        )
    end
end

return {
    RunCommand = run_command,
}
