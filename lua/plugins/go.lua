require('go').setup {
    lsp_gofumpt = true
}

-- Run gofumpt + goimports on write
vim.api.nvim_exec([[autocmd BufWritePre *.go :silent! lua require('go.format').goimport()]], false)
