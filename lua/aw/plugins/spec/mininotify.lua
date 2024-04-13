if not AW.has('mini.notify') then return end
if vim.g.vscode then return end

require('mini.notify').setup {
    window = {
        config = {
            border = 'solid',
        },
        winblend = AW.ui.winblend,
    },
    lsp_progress = { duration_last = 1000 },
}
