return {
    'hiphish/rainbow-delimiters.nvim',
    submodules = false,
    enabled = not AW.is_root() and not vim.g.vscode,
    event = {'BufReadPost', 'BufNewFile'},
}
