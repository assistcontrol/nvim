-- Key mappings
AW.maps = {}

-- Helper functions
local cmd = function(command)
    return table.concat({'<Cmd>', command, '<CR>'})
end

local wkmap = function(lhs, rhs, desc)
    return { "<leader>" .. lhs, cmd(rhs), desc = desc }
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

-- Emacs-style bindings
map('i', '<C-a>', '<C-o>^')
map('i', '<C-e>', '<C-o>$')
map('i', '<C-k>', '<C-o>C')
-- Command mode
map('c', '<C-a>', '<Home>')
map('c', '<C-e>', '<End>')

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

AW.maps.leader = {
    -- In which-key.nvim format
    wkmap('k', [[wincmd k]], 'window up'),
    wkmap('j', [[wincmd j]], 'window down'),
    wkmap('h', [[wincmd h]], 'window left'),
    wkmap('l', [[wincmd l]], 'window right'),

    wkmap('<leader>', [[b#]],                       'alternate'),
    wkmap('<cr>', [[lua AW.next_pane()]],           'next window'),
    wkmap('A', 'ggVG',                              'select all'),
    wkmap('D', [[lua MiniBufremove.delete()]],      'close buffer'),
    wkmap('e', [[lua AW.filebrowser()]],            'browse'),
    wkmap('q', [[lua MiniFiles.open()]],            'explorer'),
    wkmap('Q', [[lua AW.toggle_quickfix()]],        'toggle quickfix'),
    wkmap('x', [[lua MiniFiles.open()]],            'explorer'),
    wkmap('z', [[lua require('mini.misc').zoom()]], 'zoom'),

    {'b', group = 'buffer'},
    wkmap('bb', [[Pick buffers]],                'list'),
    wkmap('bd', [[lua MiniBufremove.wipeout()]], 'delete'),
    wkmap('bn', [[bnext]],                       'next'),
    wkmap('bp', [[bprevious]],                   'previous'),
    wkmap('b<leader>', [[bnext]],                 'next'),

    wkmap('c', [[lua require('CopilotChat').open({selection = require('CopilotChat.select').buffer})]], 'copilot chat'),

    {'d', group = 'code dx'},
    wkmap('dn', [[lua vim.diagnostic.goto_next({float = true})]], 'next'),
    wkmap('dp', [[lua vim.diagnostic.goto_prev({float = true})]], 'previous'),

    {'f',  group = 'find'},
    wkmap('fb', [[Pick buffers]],                   'buffers'),
    wkmap('fc', [[Pick commands]],                  'commands'),
    wkmap('fd', [[Pick diagnostic]],                'diagnostic'),
    wkmap('fe', [[Pick explorer]],                  'explorer'),
    wkmap('fg', [[Pick grep_live]],                 'grep'),
    wkmap('fh', [[Pick help]],                      'help'),
    wkmap('fk', [[Pick keymaps]],                   'keymaps'),
    wkmap('ff', [[lua AW.filebrowser()]],           'files'),
    wkmap('fl', [[Pick buf_lines scope="current"]], 'local buffer'),
    wkmap('fm', [[Pick marks]],                     'marks'),
    wkmap('fo', [[Pick options]],                   'options'),
    wkmap('fs', [[Pick spellsuggest]],              'spelling'),
    wkmap('fr', [[Pick registers]],                 'registers'),
    wkmap('fx', [[Pick history]],                   'history'),

    {'fG', group = 'git'},
    wkmap('fGb', [[Pick git_branches]], 'branches'),
    wkmap('fGc', [[Pick git_commits]],  'commits'),
    wkmap('fGf', [[Pick git_files]],    'files'),


    {'K', group = 'make'},
    wkmap('Km', [[TermExec cmd="mm"]],      'all'),
    wkmap('Kt', [[TermExec cmd="mm test"]], 'test'),

    {'o', group = 'fold'},
    wkmap('oc', 'zc', 'close'),
    wkmap('oC', 'zM', 'close all'),
    wkmap('oo', 'zo', 'open'),
    wkmap('oO', 'zR', 'open all'),
    wkmap('o<leader>', 'za', 'toggle'),
}

-- Gitsigns sets keymaps via a callback
function AW.maps.gitsigns(bufnr)
    map('n', '[c', cmd[[lua require('gitsigns').prev_hunk()]], {buffer = bufnr, desc = 'previous git hunk'})
    map('n', ']c', cmd[[lua require('gitsigns').next_hunk()]], {buffer = bufnr, desc = 'next git hunk'})
end
