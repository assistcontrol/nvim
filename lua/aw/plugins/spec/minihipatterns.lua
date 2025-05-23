if not AW.has('mini.hipatterns') then return end
if vim.g.vscode then return end

-- Matches FOO: at the beginning of a word and highights the
-- rest of the line.
-- FOO --> %f[%w]()FOO:.*
local gen_pattern = function(pattern)
    return '%f[%w]()' .. pattern .. ':.*'
end

require('mini.hipatterns').setup {
    highlighters = {
        note     = { pattern = gen_pattern('NOTE'), group = 'MiniIconsCyan' },
        todo     = { pattern = gen_pattern('TODO'), group = 'MiniHipatternsTodo' },
        xxx      = { pattern = gen_pattern('XXX'),  group = 'MiniHipatternsFixme' },
        hexcolor = require('mini.hipatterns').gen_highlighter.hex_color()
    }
}
