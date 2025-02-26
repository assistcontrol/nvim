-- Go
return {
    'ray-x/go.nvim',
    enabled = not AW.is_root() and not vim.g.vscode,
    ft = {'go', 'gohtmltmpl', 'gomod'},
    cmd = {'GoInstallBinaries', 'GoUpdateBinaries'},
    config = function()
        require('go').setup {
            lsp_gofumpt = true,
        }

        -- Run gofumpt + goimports on write
        AW.autocmd('BufWritePre', '*.go', function()
            require('go.format').goimports()
        end)
    end
}
