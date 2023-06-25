return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {AW.deps.devicons},
    cmd = {'NvimTreeFocus', 'NvimTreeClose'},
    keys = '<leader>x',
    opts = {
        hijack_cursor = true,

        diagnostics = {
            enable = true
        }
    }
}
