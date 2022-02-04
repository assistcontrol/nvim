local lspconfig = require('lspconfig')
local has_minicomp, _ = pcall(require, 'mini.completion')

local attach = function() end    -- Stub
if has_minicomp then
    attach = function(_, bufnr)  -- (client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')
    end
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Go
if vim.fn.executable('gopls') == 1 then
    lspconfig.gopls.setup {
        on_attach = attach
    }
end

-- Lua
if vim.fn.executable('lua-language-server') == 1 then
    lspconfig.sumneko_lua.setup {
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
