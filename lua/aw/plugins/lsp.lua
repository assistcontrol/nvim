-- LSP
return {
    'neovim/nvim-lspconfig',
    dependencies = {AW.deps.mini},
    enabled = not AW.is_root() and not vim.g.vscode,
    event = {'BufReadPre', 'BufNewFile'},

    config = function()
        local lspconfig = require('lspconfig')

        -- conf is passed to each language server
        local conf = {}
        if AW.has('mini.completion') then
            conf.attach = function(_, bufnr)  -- (client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')
            end
        end
        if AW.has('cmp_nvim_lsp') then
            conf.capabilities = require('cmp_nvim_lsp').default_capabilities()
        end

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
            text = AW.icon('warning'), texthl = 'DiagnosticSignWarn',  numhl = 'CustomWarning'
        })
        vim.fn.sign_define('DiagnosticSignInfo', {
            text = AW.icon('hint'),    texthl = 'DiagnosticSignInfo',  numhl = 'CustomMedium'
        })
        vim.fn.sign_define('DiagnosticSignHint', {
            text = AW.icon('hint'),    texthl = 'DiagnosticSignHint',  numhl = 'CustomMedium'
        })

        -- Language servers
        -- Go
        if vim.fn.executable('gopls') > 0 then
            lspconfig.gopls.setup {
                conf,
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
                conf,
                on_init = function(client)
                    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                        Lua = {
                            runtime = {
                                version = 'LuaJit',
                            },
                            diagnostics = {
                                globals = {'vim'},
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                },
                            },
                        }
                    })

                    client.notify('workspace/didChangeConfiguration', {settings = client.config.settings})
                    return true
                end
            }
        end

        -- Rust
        if vim.fn.executable('rust-analyzer') > 0 then
            lspconfig.rust_analyzer.setup({
                conf
            })
        end
    end
}
