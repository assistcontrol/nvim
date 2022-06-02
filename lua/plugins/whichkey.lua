local wk = require('which-key')

wk.setup {
    show_help = false,
    window = {
        winblend = AW.ui.winblend
    }
}

wk.register(AW.maps.leader, {mode = 'n', prefix = '<leader>'})

AW.defer [[
    hi link WhichKeyFloat CustomMedium
]]
