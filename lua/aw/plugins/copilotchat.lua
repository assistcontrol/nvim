return {
    'copilotc-nvim/copilotchat.nvim',
    branch = 'canary',
    dependencies = {
        { 'zbirenbaum/copilot.lua' },
        { 'nvim-lua/plenary.nvim' },
    },
    enabled = not AW.is_root() and not vim.g.vscode,
    event = {'BufReadPre', 'BufNewFile'},
    opts = {},
}
