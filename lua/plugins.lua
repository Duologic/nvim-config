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
packadd('neosolarized')

packadd('nvim-lspconfig')

packadd('vim-jsonnet')
packadd('vim-markdown')
packadd('vim-terraform')

packadd_defer('gitsigns')
packadd_defer('nvim-web-devicons')
packadd_defer('octo')
packadd_defer('syntastic')
packadd_defer('telescope')
packadd_defer('vim-fugitive')
packadd_defer('vim-rhubarb')
packadd_defer('vim-surround')


vim.defer_fn(function()
    vim.cmd('helptags ALL')
end, 0)
