-- Extra tree-sitter objects
return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = AW.deps.treesitter,
    enabled = not AW.is_root(),
    event = {'BufReadPost', 'BufNewFile'}
}
