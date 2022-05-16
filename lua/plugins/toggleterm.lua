require('toggleterm').setup {
    open_mapping     = [[<C-;>]],
    insert_mapping   = false, -- Only fire in normal mode
    terminal_mapping = true,  -- Link to open_mapping

    direction  = 'float',
    float_opts = {
        border = require('colors').border,
        winblend = 0
    },
    highlights = {
        FloatBorder = {
            link = 'CustomMediumBright'
        },
        NormalFloat = {
            link = 'CustomMediumBright'
        }
    }
}
