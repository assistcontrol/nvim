if not AW.has('mini.animate') then return end

local animate = require('mini.animate')

animate.setup {
    -- Cursor
    cursor = {
        timing = animate.gen_timing.cubic({
            duration = 50,
            unit     = 'total'
        }),
    },
    -- Scroll
    scroll = { enable = false },
    -- Windows
    open   = { enable = false },
    close  = { enable = false },
}
