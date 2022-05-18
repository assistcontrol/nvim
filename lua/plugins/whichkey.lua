local wk = require('which-key')

wk.setup {
    show_help = false
}

wk.register(AW.maps.leader, {mode = 'n', prefix = '<leader>'})
