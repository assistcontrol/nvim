-- Go
return {
    'ray-x/go.nvim',
    enabled = not AW.is_root(),
    ft = {'go', 'gohtmltmpl', 'gomod'},
    cmd = {'GoInstallBinaries', 'GoUpdateBinaries'},
    config = function()
        require('go').setup {
            lsp_gofumpt = true
        }

        -- Run gofumpt + goimports on write
        AW.autocmd('BufWritePre', '*.go', function()
            require('go.format').goimport()
        end)
    end
}
