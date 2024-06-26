-- Keybinding window
return {
    'folke/which-key.nvim',
    enabled = not vim.g.vscode,
    lazy = true,
    keys = vim.g.mapleader,
    config = function()
        local wk = require('which-key')
        wk.setup {
            show_help = false,
            icons = {
                breadcrumb = '',  -- Shown in command line
                group      = AW.icon('lsp'),
                separator  = ''   -- Between key and description
            },
            window = {
                winblend = AW.ui.winblend
            }
        }

        wk.register(AW.maps.leader.n, {mode = 'n', prefix = '<leader>'})
        wk.register(AW.maps.leader.v, {mode = 'v', prefix = '<leader>'})
    end
}
