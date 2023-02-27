-- Extra tree-sitter objects
return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = AW.deps.treesitter,
    event = {'BufReadPost', 'BufNewFile'}
}
