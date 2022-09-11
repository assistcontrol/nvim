if not AW.has('go') then return end

require('go').setup {
    lsp_gofumpt = true
}

-- Run gofumpt + goimports on write
vim.cmd([[autocmd BufWritePre *.go :silent! lua require('go.format').goimport()]])
