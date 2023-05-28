require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = false,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set(
            'n',
            '<leader>tb',
            gs.toggle_current_line_blame,
            {
                buffer = bufnr,
                desc = 'toggle current line blame',
            }
        )
    end
})
