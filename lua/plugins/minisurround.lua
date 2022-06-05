require('mini.surround').setup {
    custom_surroundings = {
        s = {
            input  = {find = '%[%[.-%]%]', extract = '^(..).*(..)$'},
            output = {left = '[[', right = ']]'}
        }
    },
    mappings = {  -- Behave like vim-surround
        add     = 'ys',
        delete  = 'ds',
        replace = 'cs',
        find      = '',
        find_left = '',
        highlight = '',
        update_n_lines = ''
    },
    search_method = 'cover_or_nearest'
}
