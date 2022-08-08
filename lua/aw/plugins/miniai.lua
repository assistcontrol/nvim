local treesitter_gen = require('mini.ai').gen_spec.treesitter

require('mini.ai').setup {
    custom_textobjects = {
        f = treesitter_gen {a = '@function.outer', i = '@function.inner'}
    }
}
