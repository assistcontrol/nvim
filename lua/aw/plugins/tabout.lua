-- Tab out of braces
return {
    'abecodes/tabout.nvim',
    dependencies = AW.deps.treesitter,
    event = 'BufReadPre',
    opts = {
        act_as_shift_tab = true
    }
}
