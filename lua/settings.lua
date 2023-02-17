-- General settings
vim.g.mapleader = '\\'
vim.g.maplocalleader = ','
vim.o.cmdheight = 2
vim.o.completeopt = 'menu,menuone,noselect,preview'
vim.o.encoding = 'utf-8'
vim.o.laststatus = 2
vim.o.mouse = 'a'
vim.o.visualbell = true
vim.o.wildmenu = true

-- Theme and colors
vim.o.background = 'light'
vim.o.termguicolors = true
vim.o.colorcolumn = '90'

-- Linenumber
vim.o.number = true
vim.o.relativenumber = true

-- Cursorline
vim.o.cursorline = true
-- Only show cursorline in the current window and in normal mode.
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline
      au WinEnter * set cursorline
      au InsertEnter * set nocursorline
      au InsertLeave * set cursorline
  augroup END
]])

-- Linebreak and indent behavior
vim.o.linebreak = true
vim.o.textwidth = 90
vim.o.showbreak= '↪'
vim.o.list = true
vim.o.listchars = 'tab:→ ,trail:·,nbsp:␣,extends:◣,precedes:◢'
--- vim.o.listchars = 'tab:→ ,trail:·,eol:$,nbsp:␣,extends:◣,precedes:◢'
--- vim.diagnostic.match('highlight trailing space', '/%s+$/', {})

--- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Format
vim.o.formatoptions = 'tcrqnb1j'
vim.o.fixeol = false

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true

-- Spellcheck
vim.cmd([[
    autocmd FileType markdown setlocal spell spelllang=en_us
    autocmd FileType gitcommit setlocal spell spelllang=en_us
]])

-- Restore last cursor position
vim.cmd([[
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
]])

-- Shortcut for Git/fugitive
vim.cmd([[
    command! -nargs=0 Gblame Git blame
]])
