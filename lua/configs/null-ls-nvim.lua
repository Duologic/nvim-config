local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.cbfmt.with({
            extra_args = { '--config', vim.fn.expand('~/.config/nvim/cbfmt.toml') }
        }),
    },
})
