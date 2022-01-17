require('mini.completion').setup()

local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not has_lspconfig then return end

local attach = function(_, bufnr)  -- (client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Load language servers
lspconfig.gopls.setup {
    on_attach = attach
}

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
