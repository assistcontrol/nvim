-- Loop closure (bracket/brace insertion)
return {
    'rrethy/nvim-treesitter-endwise',
    dependencies = AW.deps.treesitter,
    event = {'BufReadPost', 'BufNewFile'}
}
