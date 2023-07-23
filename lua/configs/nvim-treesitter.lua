local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.jsonnet = {
    install_info = {
        url = '/home/duologic/git/Duologic/tree-sitter-jsonnet', -- local path or git repo
        files = { 'src/parser.c', 'src/scanner.c' },             -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        generate_requires_npm = true,                            -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = true,                   -- if folder contains pre-generated src/parser.c
    },
    filetype = 'jsonnet',                                        -- if filetype does not match the parser name
}

require 'nvim-treesitter'.setup()
require 'nvim-treesitter.configs'.setup({
    highlight = { enable = true }
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr   = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel  = 1000

-- Get highlight group
vim.api.nvim_create_user_command(
    'TSCaptureUnderCursor',
    function()
        print(
            vim.inspect(
                vim.treesitter.get_captures_at_cursor(0)
            )
        )
    end,
    {})
