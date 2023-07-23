local null_ls = require('null-ls')

local function getFileType()
    local ft = vim.bo.filetype

    for index, value in ipairs({ 'markdown', 'org', 'restructuredtext' }) do
        if value == ft then
            return ft
        end
    end

    return 'markdown' -- fallback
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.cbfmt.with({
            filetypes = { 'markdown', 'org', 'gitcommit' },
            extra_args = {
                '--config', vim.fn.expand('~/.config/nvim/cbfmt.toml'),
                '--parser', getFileType(),
            }
        }),
    },
})
