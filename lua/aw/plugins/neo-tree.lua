-- Explorer
vim.g.neo_tree_remove_legacy_commands = true

vim.fn.sign_define('DiagnosticSignError', {text = AW.icon('error')})
vim.fn.sign_define('DiagnosticSignWarn',  {text = AW.icon('warning')})
vim.fn.sign_define('DiagnosticSignInfo',  {text = AW.icon('hint')})
vim.fn.sign_define('DiagnosticSignHint',  {text = AW.icon('hint')})

return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {AW.deps.devicons, AW.deps.nui, AW.deps.plenary},
    cmd = {'Neotree', 'Neotree buffers'},
    keys = '<leader>x',
    opts = {
        close_if_last_window = true,
        popup_border_style = 'rounded',

        window = {
            mappings = {
                ['<CR>']  = 'open_with_window_picker',
                ['<C-h>'] = 'split_with_window_picker',
                ['<C-v>'] = 'vsplit_with_window_picker',
            }
        },

        default_component_configs = {
            modified = {symbol = AW.icon('modified')}
        },

        event_handlers = {
            {   event = "neo_tree_window_after_close",
                handler = function() vim.cmd [[wincmd =]] end
            },
            {   event = "neo_tree_window_after_open",
                handler = function() vim.cmd [[wincmd =]] end
            },
        }

    }
}
