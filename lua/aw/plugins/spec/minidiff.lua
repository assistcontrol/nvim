if not AW.has('mini.diff') then return end

require('mini.diff').setup {
    view = {
        style = 'sign',
        signs = {
            add    = AW.icon('thickvert'),
            change = AW.icon('vertbar'),
            delete = AW.icon('horizlow'),
        },
    },

    mappings = {
        goto_first = '[C',
        goto_prev  = '[c',
        goto_next  = ']c',
        goto_last  = ']C',
    },
}
