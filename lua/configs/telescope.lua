local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

telescope.setup()

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { noremap = true, desc = 'find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { noremap = true, desc = 'live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { noremap = true, desc = 'buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { noremap = true, desc = 'help tags' })
