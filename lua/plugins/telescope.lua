require('telescope').setup {
    defaults = {
        border = true,
        borderchars = require('colors').borderchars,
        file_ignore_patterns = {'node_modules'},
        layout_strategy = 'flex',
        mappings = {
            i = {
                ['<C-u>'] = false
            }
        },
        path_display = function(_, path)  -- remove leading ./
            return path:gsub('^./', '')
        end,
    }
}

require('mapping').telescope()
require('util').on_load [[
    hi link TelescopeBorder    CustomMediumBright
    hi link TelescopeNormal    CustomMediumBright
    hi link TelescopeSelection CustomHighlight
]]
