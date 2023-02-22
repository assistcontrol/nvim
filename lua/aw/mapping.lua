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

-- Override ^W^W to skip nvim-tree
map('n', '<C-w><C-w>', AW.next_window)

-- Search using proper regexes by default
map('n', '/', [[/\v]])
map('n', '?', [[?\v]])

-- // and ?? clear search results
map('n', '//', cmd[[nohlsearch]])
map('n', '??', cmd[[nohlsearch]])

-- Tab/S-Tab through completion list
map('i', '<Tab>',   [[pumvisible() ? '<C-n>' : '<Tab>']],   {expr = true})
map('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<S-Tab>']], {expr = true})

-- S surrounds visual region
map('x', 'S', cmd[[lua MiniSurround.add('visual')]])

-- ^\ saves
map({'i', 'n'}, '<C-\\>', cmd[[write]])

-- \\ shows buffers in Telescope
map('n', '\\\\',  cmd[[Telescope buffers]], {desc = 'buffers (Telescope)'})
-- \[ opens Telescope
map('n', '\\[',  cmd[[Telescope]], {desc = 'Telescope'})

H.pick_window = function()
    local winid = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(winid)
end

H.refactor = function(cmd)
    return string.format([[<Esc><Cmd>lua require('refactoring').refactor('%s')<CR>]], cmd), string.lower(cmd), {silent = true, expr = false}
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
        e = {cmd[[lua AW.filebrowser()]],            'browse'},
        q = {cmd[[lua MiniBufremove.delete()]],      'close buffer'},
        w = {H.pick_window,                          'pick window'},
        x = {cmd[[NvimTreeFocus]],                   'explorer'},
        X = {cmd[[NvimTreeClose]],                   'unexplorer'},
        z = {cmd[[lua require('mini.misc').zoom()]], 'zoom'},

        b = {
            name = 'buffer',
            b = {cmd[[Telescope buffers]],          'list'},
            d = {cmd[[lua MiniBufremove.delete()]], 'delete'},
            n = {cmd[[bnext]],                      'next'},
            p = {cmd[[bprevious]],                  'previous'},
            ['<leader>'] = {cmd[[bnext]],           'next'},
        },

        d = {
            name = 'code dx',
            n = {cmd[[lua vim.diagnostic.goto_next({float = true})]], 'next'},
            p = {cmd[[lua vim.diagnostic.goto_prev({float = true})]], 'previous'},
        },

        f = {
            name = 'find',
            b = {cmd[[Telescope buffers]],     'buffers'},
            d = {cmd[[Telescope diagnostics]], 'diagnostics'},
            e = {cmd[[Explore]],               'explorer'},
            g = {cmd[[Telescope live_grep]],   'grep'},
            h = {cmd[[Telescope help_tags]],   'help'},
            t = {cmd[[Telescope]],             'telescope'},
            f = {cmd[[lua AW.filebrowser()]],  'files'}
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

        r = {
            name = 'refactor',
            b = {H.refactor('Extract Block')},
            f = {H.refactor('Extract Block To File')},
            i = {H.refactor('Inline Variable')}
        }
    },

    v = {
        r = {
            name = 'refactor',
            e = {H.refactor('Extract Function')},
            f = {H.refactor('Extract Function To File')},
            v = {H.refactor('Extract Variable')},
            i = {H.refactor('Inline Variable')},
            r = {[[<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], 'refactors'}
        }
    }
}

-- Gitsigns sets keymaps via a callback
function AW.maps.gitsigns(bufnr)
    map('n', '[c', cmd[[lua require('gitsigns').prev_hunk()]], {buffer = bufnr, desc = 'previous git hunk'})
    map('n', ']c', cmd[[lua require('gitsigns').next_hunk()]], {buffer = bufnr, desc = 'next git hunk'})
end
