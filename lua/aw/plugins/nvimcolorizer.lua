-- Color highlighting
return {
    'nvchad/nvim-colorizer.lua',
    enabled = not AW.is_root(),
    event = 'BufReadPre',
    opts = {}
}
