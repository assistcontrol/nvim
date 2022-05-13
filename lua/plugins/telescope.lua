local map = require('util').map

require('telescope').setup {
    defaults = {
        file_ignore_patterns = {'node_modules'},
        layout_strategy = 'flex',
        path_display = function(_, path)  -- remove leading ./
            return path:gsub('^./', '')
        end,
    }
}

function FileBrowser(dir)
    if dir then vim.cmd('lcd ' .. dir) end
    require('telescope.builtin').find_files()
end

-- ^P opens fuzzy finder
map('', '<C-p>', [[:lua FileBrowser()<CR>]])

-- ^T opens full telescope browser
map('', '<C-t>', ':Telescope<CR>')
