-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, { desc = 'open diagnostic in window' })
vim.keymap.set('n', '<space>e', vim.diagnostic.setloclist, { desc = 'open diagnostics in loclist' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'goto prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'goto next diagnostic' })

local function list_workspace_folders()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

local function format()
    vim.lsp.buf.format { async = true }
end

local function peek_definition()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result)
        if result == nil or vim.tbl_isempty(result) then
            return nil
        end
        vim.lsp.util.preview_location(result[1])
    end)
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd(
    'LspAttach',
    {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            function OptsWithDescription(desc)
                return { buffer = opts.buffer, desc = 'LSP ' .. desc }
            end

            vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                OptsWithDescription('declaration'))
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
                OptsWithDescription('definition'))
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
                OptsWithDescription('implementation'))
            vim.keymap.set('n', 'gp', peek_definition,
                OptsWithDescription('peek definition'))
            vim.keymap.set('n', 'gr', vim.lsp.buf.references,
                OptsWithDescription('references'))
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition,
                OptsWithDescription('type definition'))
            vim.keymap.set('n', '<space>R', vim.lsp.buf.rename,
                OptsWithDescription('rename'))
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,
                OptsWithDescription('add workspace folder'))
            vim.keymap.set('n', '<space>wl', list_workspace_folders,
                OptsWithDescription('list workspace folders'))
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                OptsWithDescription('remove workspace folder'))
            vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action,
                OptsWithDescription('code action'))
            vim.keymap.set({ 'n', 'v' }, '<space>f', format,
                OptsWithDescription('format'))
        end,
    }
)


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

lspconfig.gopls.setup {
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}

lspconfig.lua_ls.setup {
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'vim',
                    'require',
                    'buffer',
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            format = {
                defaultConfig = {
                    quote_style = 'single'
                }
            }
        },
    },
}

lspconfig.jsonnet_ls.setup {
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = { 'jsonnet-language-server', '--lint' },
    settings = {
        formatting = {
            UseImplicitPlus = false,
        }
    }
}

-- Format on save
vim.api.nvim_create_autocmd(
    'BufWritePre',
    {
        buffer = buffer,
        callback = function()
            vim.lsp.buf.format { async = false }
        end
    }
)
