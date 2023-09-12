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
-- Don't show relativenumber in insert mode or NetrwTreeListing.
local relnum = vim.api.nvim_create_augroup(
    'relnum',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    { 'InsertEnter' },
    {
        group = relnum,
        command = 'set norelativenumber',
    }
)
vim.api.nvim_create_autocmd(
    { 'InsertLeave' },
    {
        group = relnum,
        command = 'set relativenumber',
    }
)
vim.api.nvim_create_autocmd(
    { 'BufWinEnter', 'WinEnter', 'InsertLeave' },
    {
        pattern = '!NetrwTreeListing',
        group = relnum,
        command = 'set relativenumber',
    }
)

-- Cursorline
--vim.o.cursorline = true
-- Only show cursorline in the current window.
local cline = vim.api.nvim_create_augroup(
    'cline',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    { 'BufWinLeave', 'WinLeave' },
    {
        group = cline,
        command = 'set nocursorline',
    }
)
vim.api.nvim_create_autocmd(
    { 'BufWinEnter', 'WinEnter' },
    {
        group = cline,
        command = 'set cursorline',
    }
)

-- Linebreak and indent behavior
vim.o.linebreak = true
vim.o.textwidth = 0
vim.o.showbreak = '↪'
vim.o.breakindent = true
vim.o.list = true
vim.opt.listchars = {
    tab = '→ ',
    trail = '•',
    nbsp = '␣',
    extends = '◣',
    precedes = '◢',
    conceal = '˚',
}
--- vim.diagnostic.match('highlight trailing space', '/%s+$/', {})

--- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Format
vim.o.formatoptions = 'rqnb1j'
vim.o.fixeol = false

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true

-- Spellcheck
vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = { 'gitcommit', 'markdown' },
        callback = function()
            vim.opt_local.spell = true
            vim.opt_local.spelllang = 'en_gb'
        end
    }
)

-- Restore last cursor position
vim.api.nvim_create_autocmd(
    'BufReadPost',
    {
        command = [[
            if line("'\"") > 0 && line("'\"") <= line("$") |
              exe "normal! g`\"" |
            endif
        ]]
    }
)

-- Shortcut for Git/fugitive
vim.api.nvim_create_user_command('Gblame', 'Git blame', {})

vim.o.timeout = true
vim.o.timeoutlen = 300


-- absolute width of netrw window
vim.g.netrw_winsize = -28
-- do not display info on the top of window
vim.g.netrw_banner = 0
-- tree-view
vim.g.netrw_liststyle = 3
-- sort is affecting only: directories on the top, files below
vim.g.netrw_sort_sequence = '[\\/]$,*'

vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<cr>')
vim.api.nvim_create_autocmd(
    { 'FileType' },
    {
        pattern = 'netrw',
        callback = function()
            -- Each time Lexplore is toggled on, it will create a new buffer but not wipe the previous one.
            -- This will wipeout netrw buffers when they are hidden.
            vim.opt_local.bufhidden = 'wipe'
        end
    }
)
