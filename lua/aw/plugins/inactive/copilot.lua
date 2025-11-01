return {
    'zbirenbaum/copilot.lua',
    enabled = not AW.is_root() and not vim.g.vscode,
    event = {'BufReadPre', 'BufNewFile'},
    opts = {
        copilot_model = 'gpt-5',
        filetypes = {
            ['*'] = true,
        },
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept  = '<C-o>',
                next    = '<C-_>',
                dismiss = false
            }
        },
        panel = {
            enabled = false
        }
    }
}
