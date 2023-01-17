-- Emacs bindings
return {
    'linty-org/readline.nvim',
    event = 'InsertEnter',
    config = function()
        local map = vim.keymap.set
        local readline = require('readline')

        map('!', '<C-a>', readline.dwim_beginning_of_line)
        map('!', '<C-e>', readline.end_of_line)
        map('!', '<C-w>', readline.backward_kill_word)
        map('!', '<C-k>', readline.kill_line)
        map('!', '<C-u>', function() readline.end_of_line(); readline.dwim_backward_kill_line() end)
    end
}
