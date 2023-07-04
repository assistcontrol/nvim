return {
    'hiphish/rainbow-delimiters.nvim',
    enabled = not AW.is_root(),
    event = {'BufReadPost', 'BufNewFile'}
}
