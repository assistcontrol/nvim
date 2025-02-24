-- Little snacks

-- Turns 'foo' into { 'foo', mode = {'n', 'i'} }
local everywhere = function(cmd)
    return {cmd, mode = {'n', 'i'}}
end

-- Set up a toggle switch in which-key
local leader = function(ch) return '<leader>p' .. ch end
local toggle = function(opt, lhs)
    Snacks.toggle.option(opt, {name = opt}):map(leader(lhs))
end

local opts = {
    animate  = {},
    bigfile  = {},
    debug    = {},
    dim      = {},
    explorer = {},
    indent   = {
        enabled = true,
        only_current = true,
        animate = {
            style  = 'out',
            easing = 'linear',
            duration = {
                step  = 20,
                total = 500,
            },
        },
    },
    input = {},
    notifier = {
        timeout  = 3000,
        top_down = false,
    },
    picker = {
        matcher = {
            frecency = true,
            history_bonus = true,
        },
        win = {
            input = {
                keys = {
                    ['<ESC>']      = everywhere('close'),
                    ['<C-c>']      = everywhere('close'),
                    ['<PageUp>']   = everywhere('list_scroll_up'),
                    ['<PageDown>'] = everywhere('list_scroll_down'),
                },
            },
        },
    },
    quickfile = {},
    scroll = {
        animate = {
            easing = 'inOutQuart',
        },
    },
    toggle = {
        color = {
            disabled = 'red',
        },
        wk_desc = {
            enabled = 'On: ',
            disabled = 'Off: ',
        },
    },
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

        -- toggle('number', 'n')
        toggle('spell',  's')
        toggle('wrap',   'w')
        Snacks.toggle.line_number():map(leader('n'))
        Snacks.toggle.dim():map(leader('d'))
    end,
}
