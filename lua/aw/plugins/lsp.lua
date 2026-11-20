-- LSP
return {
    'neovim/nvim-lspconfig',
    dependencies = {AW.deps.mini},
    enabled = not AW.is_root() and not vim.g.vscode,
    lazy = false,    -- Available immediately
    priority = 500,  -- Load before most LSP consumers

    config = function()
        if AW.has('mini.completion') then
            local on_attach = function(args)
                vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
            end
            vim.api.nvim_create_autocmd('LspAttach', {callback = on_attach})
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
                severity = {
                    min = vim.diagnostic.severity.ERROR,
                    max = vim.diagnostic.severity.ERROR,
                },
            }
        }
        -- Show diagnostic window automatically on relevant lines
        AW.autocmd('CursorHold', function()
            vim.diagnostic.open_float()
        end)

        -- Highlight line numbers with LSP messages and set gutter symbols
        vim.diagnostic.config({
            signs = {
                linehl = {
                    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                    [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
                    [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
                    [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = 'CustomError',
                    [vim.diagnostic.severity.WARN]  = 'CustomWarning',
                    [vim.diagnostic.severity.INFO]  = 'CustomMedium',
                    [vim.diagnostic.severity.HINT]  = 'CustomMedium',
                },
                text = {
                    [vim.diagnostic.severity.ERROR] = AW.icon('errorSm'),
                    [vim.diagnostic.severity.WARN]  = AW.icon('warning'),
                    [vim.diagnostic.severity.INFO]  = AW.icon('hint'),
                    [vim.diagnostic.severity.HINT]  = AW.icon('hint'),
                },
            },
        })

        -- Language servers

        -- Go
        vim.lsp.config.gopls = {
            settings = {
                gopls = {
                    gofumpt = true
                }
            }
        }
        vim.lsp.enable('gopls')

        -- Lua
        vim.lsp.config.lua_ls = {
            filetypes = { 'lua' },
            on_init = function(client)
                local folders = client.workspace_folders
                local root = folders and folders[1] and folders[1].name

                local editing_config = root and (
                    root == vim.fn.stdpath('config') or
                    root == vim.fn.expand(AW_MODULE_PATH)
                )

                if not editing_config then
                    return
                end

                client.config.settings = vim.tbl_deep_extend('force',
                    client.config.settings or {},
                    {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT',
                                path = {
                                    'lua/?.lua',
                                    'lua/?/init.lua',
                                },
                            },
                            diagnostics = {
                                globals = {'vim'},
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                    vim.fn.stdpath('config'),
                                    vim.fn.expand(AW_MODULE_PATH),
                                },
                            },
                        },
                    }
                )

                client:notify('workspace/didChangeConfiguration', {
                    settings = client.config.settings,
                })
            end,
        }
        vim.lsp.enable('lua_ls')

        -- Perl
        vim.lsp.enable('perl_lsp')

        -- Rust
        vim.lsp.enable('rust_analyzer')

        -- Templ
        vim.lsp.enable('templ')

        -- Example
        -- vim.lsp.config.some_lsp = { ... }
        -- vim.lsp.enable('some_lsp')

        -- Fallback for languages without an installed LSP
        vim.lsp.config.ctags_lsp = {
            filetypes = {
                'automake', 'awk', 'bash', 'c', 'cmake', 'cpp',
                'cs', 'css', 'dtd', 'html', 'javascript', 'json',
                'make', 'markdown', 'nsis', 'php', 'python', 'r',
                'ruby', 'scdoc', 'scss', 'sh', 'sql', 'tcl',
                'typescript', 'v', 'vim', 'xml', 'xslt', 'yaml',
                -- Potentially problematic:
                -- 'zsh',
            },
        }
        vim.lsp.enable('ctags_lsp')
    end
}
