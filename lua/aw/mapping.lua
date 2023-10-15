-- Key mappings
AW.maps = {}

-- Helper functions
local H = {}

local cmd = function(command)
    return table.concat({'<Cmd>', command, '<CR>'})
end

local map = vim.keymap.set

-- Mash j and k, or jj/kk in place of ESC
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
-- Sometimes it comes out as jj or kk
map('i', 'jj', '<Esc>')
map('i', 'kk', '<Esc>')

-- Move normally onto wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- ^J/^K jumps buffers
map('n', '<C-j>', cmd[[bnext]])
map('n', '<C-k>', cmd[[bprevious]])

-- CR selects current word
-- This is a fallback. CR does node_incremental in treesitter.
map('n', '<CR>', 'viw')

-- Override ^W^W to skip nvim-tree
map('n', '<C-w><C-w>', AW.next_window)

-- S surrounds visual region
map('x', 'S', cmd[[lua MiniSurround.add('visual')]])

-- ^\ saves
map({'i', 'n'}, '<C-\\>', cmd[[write]])

-- \\ shows buffers in picker
map('n', '\\\\',  cmd[[Pick buffers]], {desc = 'buffers (Picker)'})
-- \[ opens picker
map('n', '\\[',  cmd[[Pick files]], {desc = 'Picker'})

-- mini.completion
map('i', '<Tab>',   [[pumvisible() ? '<C-n>' : '<Tab>']],   {expr = true})
map('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<S-Tab>']], {expr = true})
map('i', '<CR>',    [[v:lua.AW.cr_action()]],               {expr = true})

H.pick_window = function()
    local winid = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(winid)
end

AW.maps.leader = {
    n = {
        -- In which-key.nvim format
        k = {cmd[[wincmd k]], 'window up'},
        j = {cmd[[wincmd j]], 'window down'},
        h = {cmd[[wincmd h]], 'window left'},
        l = {cmd[[wincmd l]], 'window right'},

        ['<leader>'] = {cmd[[b#]],                   'alternate'},
        ['<cr>']     = {cmd[[lua AW.next_pane()]],   'next window'},
        A = {'ggVG',                                 'select all'},
        D = {cmd[[lua MiniBufremove.delete()]],      'close buffer'},
        e = {cmd[[lua AW.filebrowser()]],            'browse'},
        q = {cmd[[lua MiniFiles.open()]],            'explorer'},
        Q = {cmd[[lua AW.toggle_quickfix()]],        'toggle quickfix'},
        w = {H.pick_window,                          'pick window'},
        x = {cmd[[lua MiniFiles.open()]],            'explorer'},
        z = {cmd[[lua require('mini.misc').zoom()]], 'zoom'},

        b = {
            name = 'buffer',
            b = {cmd[[Pick buffers]],                'list'},
            d = {cmd[[lua MiniBufremove.wipeout()]], 'delete'},
            n = {cmd[[bnext]],                       'next'},
            p = {cmd[[bprevious]],                   'previous'},
            ['<leader>'] = {cmd[[bnext]],            'next'},
        },

        d = {
            name = 'code dx',
            n = {cmd[[lua vim.diagnostic.goto_next({float = true})]], 'next'},
            p = {cmd[[lua vim.diagnostic.goto_prev({float = true})]], 'previous'},
        },

        f = {
            name = 'find',
            b = {cmd[[Pick buffers]],         'buffers'},
            g = {cmd[[Pick grep_live]],       'grep'},
            h = {cmd[[Pick help]],            'help'},
            f = {cmd[[lua AW.filebrowser()]], 'files'}
        },

        K = {
            -- alias mm='make -j$(sysctl -n hw.ncpu)'
            name = 'make',
            m = {cmd[[TermExec cmd="mm"]],      'all'},
            t = {cmd[[TermExec cmd="mm test"]], 'test'}
        },

        o = {
            name = 'fold',
            c = {'zc', 'close'},
            C = {'zM', 'close all'},
            o = {'zo', 'open'},
            O = {'zR', 'open all'},
            ['<leader>'] = {'za', 'toggle'}
        },

    },

    v = {}
}

-- Gitsigns sets keymaps via a callback
function AW.maps.gitsigns(bufnr)
    map('n', '[c', cmd[[lua require('gitsigns').prev_hunk()]], {buffer = bufnr, desc = 'previous git hunk'})
    map('n', ']c', cmd[[lua require('gitsigns').next_hunk()]], {buffer = bufnr, desc = 'next git hunk'})
end
