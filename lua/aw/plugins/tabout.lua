-- Tab out of braces
return {
    'abecodes/tabout.nvim',
    dependencies = AW.deps.treesitter,
    opts = {
        act_as_shift_tab = true
    }
}
