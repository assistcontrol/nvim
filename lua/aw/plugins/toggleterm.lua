if not AW.has('toggleterm') then return end

require('toggleterm').setup {
    open_mapping     = [[<C-=>]],
    insert_mapping   = false, -- Only fire in normal mode
    terminal_mapping = true,  -- Link to open_mapping

    direction  = 'float',
    float_opts = {
        border = AW.ui.border,
        winblend = AW.ui.winblend
    },
    shade_terminals = false,
    highlights = {
        NormalFloat = {link = 'NormalFloat'},
        FloatBorder = {link = 'NormalFloat'}
    }
}
