-- Little snacks

-- Turns 'foo' into { 'foo', mode = {'n', 'i'} }
local everywhere = function(cmd)
    return {cmd, mode = {'n', 'i'}}
end

-- Set up a toggle switch in which-key
local leader = function(ch) return '<leader>p' .. ch end
local toggle = function(opt, lhs, name)
    name = name or opt
    Snacks.toggle.option(opt, {name = name}):map(leader(lhs))
end

local opts = {
    bigfile   = {},
    debug     = {},
    dim       = {},
    input     = {},
    quickfile = {},

    animate = {
        easing = 'inOutQuart',
    },

    dashboard = require('aw/plugins/spec/snacksdashboard'),

    explorer  = {
        auto_close = true,
    },

    indent = {
        indent = {
            only_current = true,
        },
        scope = {
            char = '┃',
            hl = 'NeoTreeFilterTerm',
            only_current = true,
        },
    },

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
    priority = 1000,

    config = function()
        local snacks = require('snacks').setup(opts)
        _G.dd = function(...)
            Snacks.debug.inspect(...)
        end
        vim.print = _G.dd

        toggle('list!',   'l', 'List chars')
        toggle('number!', 'n', 'Line numbers')
        toggle('spell',   's', 'Spellchecking')
        toggle('wrap',    'w', 'Line wrapping')
        toggle('cursorcolumn!',   'C', 'Cursor column')
        toggle('relativenumber!', 'r', 'Relative numbers')
        Snacks.toggle.line_number():map(leader('n'))
        Snacks.toggle.dim():map(leader('d'))
    end,
}
