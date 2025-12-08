-- LSP
return {
    'neovim/nvim-lspconfig',
    dependencies = {AW.deps.mini},
    enabled = not AW.is_root() and not vim.g.vscode,
    event = {'BufReadPre', 'BufNewFile'},

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
        vim.lsp.config.gopls = {
            conf,
            settings = {
                gopls = {
                    gofumpt = true
                }
            }
        }
        vim.lsp.enable('gopls')

        vim.lsp.config.lua_ls = {
            conf,
            filetypes = { 'lua' },
            root_markers = {
                '.luarc.json',
                '.luarc.jsonc',
                '.luacheckrc',
                '.styluaa.toml',
                '.git',
            },
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if path ~= vim.fn.stdpath('config') and
                      (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                        return
                    end
                end

                client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                        },
                    },
                })

                client.notify('workspace/didChangeConfiguration', {settings = client.config.settings})
                return true
            end,
        }
        vim.lsp.enable('lua_ls')

        vim.lsp.config.rust_analyzer = {
            conf
        }
        vim.lsp.enable('rust_analyzer')
    end
}
