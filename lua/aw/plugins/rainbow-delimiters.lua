return {
    'hiphish/rainbow-delimiters.nvim',
    enabled = not AW.is_root() and not vim.g.vscode,
    event = {'BufReadPost', 'BufNewFile'}
}
