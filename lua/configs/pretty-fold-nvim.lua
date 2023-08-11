require('pretty-fold').setup({
    fill_char = '—',
    keep_indentation = true,
    remove_fold_markers = false,
    sections = {
        left = {
            'content',
        },
        right = {
            ' ', 'number_of_folded_lines', ' ',
            function(config) return config.fill_char:rep(3) end
        }
    }
})
