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
        vim.cmd([[autocmd BufWritePre *.go :silent! lua require('go.format').goimport()]])
    end
}
