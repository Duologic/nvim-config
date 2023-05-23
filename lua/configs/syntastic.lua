vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 1
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0
vim.g.syntastic_aggregate_errors = 1

vim.g.syntastic_enable_signs = 1
vim.g.syntastic_error_symbol = '✗✗'
vim.g.syntastic_style_error_symbol = '✠✠'
vim.g.syntastic_warning_symbol = '∆∆'
vim.g.syntastic_style_warning_symbol = '≈≈'

vim.g.syntastic_jsonnet_checkers = { 'jsonnet' }
vim.g.syntastic_jsonnet_jsonnet_exec = 'jsonnetfmt'
