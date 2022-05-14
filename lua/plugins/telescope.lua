require('telescope').setup {
    defaults = {
        file_ignore_patterns = {'node_modules'},
        layout_strategy = 'flex',
        path_display = function(_, path)  -- remove leading ./
            return path:gsub('^./', '')
        end,
    }
}

require('mapping').telescope()
