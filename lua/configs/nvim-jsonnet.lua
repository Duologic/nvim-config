require('nvim-jsonnet').setup({
    load_lsp_config = true,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    load_dap_config = true,
})
