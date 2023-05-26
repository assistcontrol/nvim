if not AW.has('mini.hipatterns') then return end

require('mini.hipatterns').setup {
    highlighters = {
        note     = { pattern = 'NOTE', group = 'MiniHipatternsNote' },
        todo     = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
        xxx      = { pattern = 'XXX',  group = 'MiniHipatternsFixme' },
        hexcolor = require('mini.hipatterns').gen_highlighter.hex_color()
    }
}
