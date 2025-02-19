return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        -- local lsp_zero = require 'lsp-zero'
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end
                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                map('<leader>Ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('<F3>', '<cmd>lua vim.lsp.buf.format({async=true})<CR>', 'Format')
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        callback = function()
                            -- if vim.lsp.buf.server_capabilities and vim.lsp.buf.server_capabilities.document_highlight then
                            vim.lsp.buf.document_highlight()
                            -- end
                        end,
                    })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })
        -- lsp_zero.extend_lspconfig {
        --     sign_text = true,
        --     -- lsp_attach = lsp_attach,
        -- }
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities {})
        local servers = {
            clangd = {
                capabilities = capabilities,
                cmd = { 'clangd', '--offset-encoding=utf-16' },
            },
            gopls = {},
            ts_ls = {
                setup = {
                    cmd = { 'typescript-language-server', '--stdio' },
                    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
                    capabilities = capabilities,
                    on_attach = require('lazydev').on_attach,
                    root_dir = require('lspconfig/util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
                },
            },
            lua_ls = {
                filetypes = { 'lua' },
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                    },
                },
            },
            pyright = {
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            ignore = { '*' },
                        },
                    },
                },
            },
            ruff = {
                cmd = { '/bin/ruff' },
                cmd_env = { RUFF_TRACE = 'messages' },
                init_options = {
                    settings = {
                        logLevel = 'debug',
                    },
                },
                on_attach = function(client, _)
                    if client.name == 'ruff' then
                        client.server_capabilities.hoverProvider = false
                    end
                end,
            },
        }

        require('mason').setup()
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format lua code
            'prettierd', -- Used to format javascript code
            'prettier',
            'gofumpt', -- Used to format go code
            'clangd',
            'clang-format',
            'codelldb',
            'ruff',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }
        require('mason-lspconfig').setup {
            ensure_installed = {},
            automatic_installation = {},

            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
    end,
}
