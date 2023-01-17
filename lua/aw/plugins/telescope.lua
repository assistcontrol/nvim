-- Fuzzy finder

return {
    'nvim-telescope/telescope.nvim',
    dependencies = AW.deps.plenary,
    config = function()
        local actions = require('telescope.actions')

        require('telescope').setup {
            defaults = {
                border = true,
                borderchars = AW.ui.borderchars,
                file_ignore_patterns = {'node_modules'},
                layout_strategy = 'flex',
                mappings = {
                    i = {
                        ['<Tab>']   = actions.move_selection_worse,
                        ['<S-Tab>'] = actions.move_selection_better,
                        ['<Esc>']   = actions.close,
                        ['<C-u>']   = false,  -- Normal ^U behaviour
                        ['<C-h>']   = require('telescope.actions.generate').which_key {
                            border_hl = 'CustomBlank'
                        }
                    }
                },
                path_display = function(_, path)  -- remove leading ./
                    return path:gsub('^./', '')
                end,
                winblend = AW.ui.winblend
            }

        }
    end
}
