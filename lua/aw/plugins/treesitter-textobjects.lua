-- Extra tree-sitter objects
-- Used by mini.ai
return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = AW.deps.treesitter,
    enabled = not AW.is_root(),
    event = {'BufReadPost', 'BufNewFile'}
}
