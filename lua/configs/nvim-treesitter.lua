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
    highlight = { enable = true },
    refactor = {
        highlight_definitions = {
            enable = false,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
        },
        --highlight_current_scope = { enable = true },
        smart_rename = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
            keymaps = {
                smart_rename = 'grr',
            },
        },
        navigation = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
            keymaps = {
                goto_definition = 'gnd',
                list_definitions = 'gnD',
                list_definitions_toc = 'gO',
                goto_next_usage = '<a-*>',
                goto_previous_usage = '<a-#>',
            },
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn', -- set to `false` to disable one of the mappings
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },
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
