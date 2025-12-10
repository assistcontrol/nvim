-- LSP
return {
    'neovim/nvim-lspconfig',
    dependencies = {AW.deps.mini},
    enabled = not AW.is_root() and not vim.g.vscode,
    lazy = false,    -- Available immediately
    priority = 500,  -- Load before most LSP consumers
    -- event = {'BufReadPre', 'BufNewFile'},

    config = function()
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
        vim.lsp.config.gopls = {
            conf,
            settings = {
                gopls = {
                    gofumpt = true
                }
            }
        }
        vim.lsp.enable('gopls')

        -- Lua
        vim.lsp.config.lua_ls = {
            conf,
            filetypes = { 'lua' },
            on_init = function(client)
                local root = client.workspace_folders and client.workspace_folders[1].name

                local editing_config =
                    root == vim.fn.stdpath('config') or
                    root == vim.fn.expand(AW_MODULE_PATH)

                local has_luarc =
                    vim.uv.fs_stat(root .. '/.luarc.json') or
                    vim.uv.fs_stat(root .. '/.luarc.jsonc')

                if has_luarc and not editing_config then
                    return
                end

                local luals_settings = client.config.settings.Lua or {}

                client.config.settings = vim.tbl_deep_extend('force', luals_settings, {
                    runtime = {
                        version = 'LuaJit',
                        path = {
                            'lua/?.lua',
                            'lua/?/init.lua',
                        },
                    },
                    diagnostics = {
                        globals = {'vim'},
                    },
                    workspace = {
                        -- Don't auto-guess things like luarocks, busted, etc.
                        checkThirdParty = false,
                        -- Make LuaLS aware of nvim runtim and the nvim config
                        library = {
                            vim.env.VIMRUNTIME,
                            vim.fn.stdpath('config'),
                            vim.fn.expand(AW_MODULE_PATH),
                        },
                    },
                })

                client.notify('workspace/didChangeConfiguration', {settings = client.config.settings})
                return true
            end,
        }
        vim.lsp.enable('lua_ls')

        -- Rust
        vim.lsp.config.rust_analyzer = {
            conf
        }
        vim.lsp.enable('rust_analyzer')
    end
}
