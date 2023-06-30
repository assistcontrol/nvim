if not AW.has('mini.ai') then return end

local treesitter_gen = require('mini.ai').gen_spec.treesitter

require('mini.ai').setup {
    custom_textobjects = {
        B = treesitter_gen {a = '@block.outer',    i = '@block.inner'},
        F = treesitter_gen {a = '@function.outer', i = '@function.inner'}
    },
    search_method = 'cover_or_nearest'
}
