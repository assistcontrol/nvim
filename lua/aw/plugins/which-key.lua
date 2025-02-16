-- Keybinding window
return {
    'folke/which-key.nvim',
    enabled = not vim.g.vscode,
    event = {'BufReadPre', 'BufNewFile'},
    lazy = true,
    keys = AW.maps.leader,
    opts = {
        show_help = false,
        icons = {
            breadcrumb = '',  -- Shown in command line
            group      = AW.icon('lsp'),
            separator  = ''   -- Between key and description
        },
        win = {
            wo = {
                winblend = AW.ui.winblend,
            },
        },
    },
}
