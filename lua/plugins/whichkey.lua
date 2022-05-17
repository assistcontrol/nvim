local wk = require('which-key')

wk.setup {}

wk.register(require('mapping').leader(), {mode = 'n', prefix = '<leader>'})
