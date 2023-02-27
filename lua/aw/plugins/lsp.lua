-- LSP
return {
    'neovim/nvim-lspconfig',
    dependencies = AW.deps.mini,
    event = {'BufReadPre', 'BufNewFile'},

    config = function()
        local lspconfig = require('lspconfig')

        local attach = function() end    -- Stub
        if AW.has('mini.completion') then
            attach = function(_, bufnr)  -- (client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')
            end
        end

        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, 'lua/?.lua')
        table.insert(runtime_path, 'lua/?/init.lua')

        -- General setup
        vim.diagnostic.config {
            float = {
                close_events = {'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
                focusable = false,
                prefix = ' ',
                source = 'if_many'
            },
            virtual_text = {
                severity = {min = 'ERROR', max = 'ERROR'}
            }
        }
        -- Show diagnostic window automatically on relevant lines
        AW.autocmd('CursorHold', function()
            vim.diagnostic.open_float()
        end)

        -- Highlight line numbers with LSP messages and set gutter symbols
        vim.fn.sign_define('DiagnosticSignError', {
            text = AW.icon('errorSm'), texthl = 'DiagnosticSignError', numhl = 'CustomError'
        })
        vim.fn.sign_define('DiagnosticSignWarn', {
            text = AW.icon('warning'), texthl = 'DiagnosticSignWarn', numhl = 'CustomWarning'
        })
        vim.fn.sign_define('DiagnosticSignInfo', {
            text = AW.icon('hint'), texthl = 'DiagnosticSignInfo', numhl = 'CustomMedium'
        })
        vim.fn.sign_define('DiagnosticSignHint', {
            text = AW.icon('hint'), texthl = 'DiagnosticSignHint', numhl = 'CustomMedium'
        })

        -- Language servers
        -- Go
        if vim.fn.executable('gopls') > 0 then
            lspconfig.gopls.setup {
                on_attach = attach,
                settings = {
                    gopls = {
                        gofumpt = true
                    }
                }
            }
        end

        -- Lua
        if vim.fn.executable('lua-language-server') > 0 then
            lspconfig.lua_ls.setup {
                on_attach = attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = runtime_path
                        },
                        diagnostics = {
                            -- Recognize the `vim` global
                            globals = {'vim'}
                        },
                        workspace = {
                            -- Recognize the nvim runtime
                            library = vim.api.nvim_get_runtime_file('', true)
                        },
                        telemetry = {
                            -- Don't send telemetry data
                            enable = false
                        }
                    }
                }
            }
        end

        -- Rust
        if vim.fn.executable('rust-analyzer') > 0 then
            lspconfig.rust_analyzer.setup({
                on_attach = attach
            })
        end
    end
}
