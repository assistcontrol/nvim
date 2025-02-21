-- Little snacks
local opts = {
    animate = {},
    bigfile = {},
    debug = {},
    indent = {
        enabled = true,
        only_current = true,
        animate = {
            style = 'out',
            easing = 'linear',
            duration = {
                step = 20,
                total = 500,
            },
        },
    },
    input = {},
    notifier = {
        timeout = 3000,
        top_down = false,
    },
    quickfile = {},
    scroll = {
        animate = {
            easing = 'inOutQuart',
        },
    },
    toggle = {},
}

return {
    'folke/snacks.nvim',
    enabled = not vim.g.vscode,

    config = function()
        local snacks = require('snacks').setup(opts)
        _G.dd = function(...)
            Snacks.debug.inspect(...)
        end
        vim.print = _G.dd
    end,
}
