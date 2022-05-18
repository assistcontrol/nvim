local wk = require('which-key')

wk.setup {
    show_help = false
}

wk.register(require('mapping').leader(), {mode = 'n', prefix = '<leader>'})
