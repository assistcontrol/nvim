if not AW.has('mini.move') then return end

require('mini.move').setup {
    mappings = {
        -- Visual mode
        up    = 'K',
        down  = 'J',
        left  = 'H',
        right = 'L',

        -- Normal mode
        line_up    = '<A-k>',
        line_down  = '<A-j>',
        line_left  = '<A-h>',
        line_right = '<A-l>',
    }
}
