-- Source plugin and its configuration immediately
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd = function(plugin)
    -- Add plugin
    vim.cmd(string.format([[packadd %s]], plugin))

    -- Try execute its configuration
    -- NOTE: configuration file should have the same name as plugin directory
    pcall(require, 'configs.' .. plugin)
end

-- Defer plugin source right after Vim is loaded
--
-- This reduces time before a fully functional start screen is shown. Use this
-- for plugins that are not directly related to startup process.
--
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd_defer = function(plugin)
    vim.defer_fn(function()
        packadd(plugin)
    end, 0)
end

-- add plugins here

packadd('plenary')
packadd('solarized-nvim')
packadd('lualine-nvim')

packadd('which-key')

packadd('cmp-luasnip')
packadd('luasnip')

packadd('cmp-nvim-lsp-signature-help')
packadd('cmp-nvim-lsp')
packadd('nvim-lspconfig')
packadd('null-ls-nvim')

packadd('nvim-cmp')

packadd('nvim-treesitter')
packadd('nvim-treesitter-refactor')
packadd('nvim-jsonnet')

--packadd('vim-markdown')
packadd('vim-terraform')
--packadd('vim-cue')

--packadd('nvim-web-devicons')

packadd_defer('gitsigns')
packadd_defer('telescope')
packadd_defer('vim-fugitive')
packadd_defer('vim-rhubarb')
packadd_defer('vim-surround')
packadd_defer('nvim-colorizer')
packadd_defer('pretty-fold-nvim')
packadd_defer('nvim-aerial')
packadd_defer('todo-comments')
packadd_defer('centerpad')

vim.defer_fn(function()
    vim.cmd('helptags ALL')
end, 0)
