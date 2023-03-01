return {
    'zbirenbaum/copilot.lua',
    enabled = not AW.is_root(),
    event = {'BufReadPre', 'BufNewFile'},
    opts = {
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept  = '<C-y>',
                next    = '<C-_>',
                dismiss = false
            }
        },
        panel = {
            enabled = false
        }
    }
}
