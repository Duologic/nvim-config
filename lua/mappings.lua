--- Ensure search results appear in the middle of the screen
vim.keymap.set('n', 'n', 'nzz', { noremap = true })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true })
vim.keymap.set('n', '*', '*zz', { noremap = true })
vim.keymap.set('n', '#', '#zz', { noremap = true })
vim.keymap.set('n', 'g*', 'g*zz', { noremap = true })
vim.keymap.set('n', 'g#', 'g#zz', { noremap = true })

--- Open URIs with the appropriate application
vim.keymap.set('n', 'gx', '<cmd>!xdg-open <cWORD> &<cr><cr>', { noremap = true })

-- Save without quiting
vim.keymap.set('n', 'ZS', '<cmd>w<cr>', { noremap = true })

-- Folding with Control+Mouse
vim.keymap.set('n', '<C-LeftMouse>', '<LeftMouse>za', { noremap = true })
