if not AW.has('neo-tree') then return end

vim.g.neo_tree_remove_legacy_commands = true

vim.fn.sign_define('DiagnosticSignError', {text = AW.icon('error')})
vim.fn.sign_define('DiagnosticSignWarn',  {text = AW.icon('warning')})
vim.fn.sign_define('DiagnosticSignInfo',  {text = AW.icon('hint')})
vim.fn.sign_define('DiagnosticSignHint',  {text = AW.icon('hint')})

require('neo-tree').setup {
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
        modified = {symbol = AW.icon('plus')}
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

AW.colorcmd.register [[
    hi! link NeoTreeFloatBorder Normal
    hi! link NeoTreeFloatTitle  CustomBright
]]
