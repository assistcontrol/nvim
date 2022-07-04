require('toggleterm').setup {
    open_mapping     = [[<C-x><C-x>]],
    insert_mapping   = false, -- Only fire in normal mode
    terminal_mapping = true,  -- Link to open_mapping

    direction  = 'float',
    float_opts = {
        border = AW.ui.border,
        winblend = AW.ui.winblend
    }
}
