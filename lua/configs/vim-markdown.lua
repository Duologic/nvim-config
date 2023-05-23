vim.g.vim_markdown.folding_disabled = 1

vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = { 'markdown' },
        callback = function()
            vim.opt_local.spell = true
            vim.opt_local.spelllang = 'en_gb'
            vim.opt_local.foldlevelstart = 1
        end
    }
)
