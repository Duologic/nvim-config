vim.g.terraform_align = 1
vim.g.terraform_fold_sections = 1
vim.g.terraform_fmt_on_save = 1

vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = { 'terraform' },
        callback = function()
            vim.opt_local.foldmarker = '{,}'
        end,
    }
)
