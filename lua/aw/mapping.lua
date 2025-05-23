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
-- NOTE: Handled by mini.keymap
-- map('i', 'jk', '<Esc>')
-- map('i', 'kj', '<Esc>')

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

-- Better home and end
map({'n', 'i', 'v', 'x', 's', 'o', 'c'}, '<Home>', AW.smart_home)
map({'n', 'i', 'v', 'x', 's', 'o', 'c'}, '<End>',  AW.smart_end)
map('n', '^', AW.smart_home, {noremap = true})

-- CR selects current word
-- This is a fallback. CR does node_incremental in treesitter.
map('n', '<CR>', 'viw')

-- Override ^W^W to skip (FS) tree windows
map('n', '<C-w><C-w>', AW.next_window)

-- ZS saves everything and quits
map('n', 'ZS', cmd[[wall | qa]])

-- ZX bails out of everything
map('n', 'ZX', cmd[[qa!]])

-- S surrounds visual region
map('x', 'S', cmd[[lua MiniSurround.add('visual')]])

-- ^\ saves
map({'i', 'n'}, '<C-\\>', cmd[[write]])

-- \\ shows buffers in picker
map('n', '\\\\',  cmd[[lua Snacks.picker.buffers()]], {desc = 'buffers'})
-- \[ opens picker
map('n', '\\[',  cmd[[lua AW.filebrowser()]], {desc = 'files'})

-- mini.completion
-- NOTE: Handled by mini.keymap
-- map('i', '<Tab>',   [[pumvisible() ? '<C-n>' : '<Tab>']],   {expr = true})
-- map('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<S-Tab>']], {expr = true})
-- map('i', '<CR>',    [[v:lua.AW.cr_action()]],               {expr = true})

-- Extend g...
-- Move normally onto wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Copy/paste with system clipboard
map({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to system clipboard'})
map( 'n',       'gp', '"+p', {desc = 'Paste from system clipboard'})

-- Reselect last visual selection
map('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"',
    {expr = true, replace_keycodes = false, desc = 'Reselect changed text'})

AW.maps.leader = {
    -- In which-key.nvim format
    wkmap('k', [[wincmd k]], 'window up'),
    wkmap('j', [[wincmd j]], 'window down'),
    wkmap('h', [[wincmd h]], 'window left'),
    wkmap('l', [[wincmd l]], 'window right'),

    wkmap('<leader>', [[b#]],                          'alternate'),
    wkmap('<cr>', [[lua AW.next_pane()]],              'next window'),
    wkmap('A',    'ggVG',                              'select all'),
    wkmap('D',    [[lua MiniBufremove.delete()]],      'close buffer'),
    wkmap('e',    [[lua AW.filebrowser()]],            'browse'),
    wkmap('q',    [[lua Snacks.picker.lsp_symbols()]], 'LSP symbols'),
    wkmap('Q',    [[lua AW.toggle_quickfix()]],        'toggle quickfix'),
    wkmap('r',    [[lua AW.toggle('relativenumber')]], 'toggle relnum'),
    wkmap('s',    [[lua Snacks.picker.git_status()]],  'git status'),
    wkmap('x',    [[lua Snacks.picker.explorer({layout = {preset = 'default'}})]],  'explorer'),
    wkmap('z',    [[lua require('mini.misc').zoom()]], 'zoom'),

    {'b', group = 'buffer', desc = 'buffer'},
    wkmap('bb', [[lua Snacks.picker.buffers()]], 'list'),
    wkmap('bd', [[lua MiniBufremove.wipeout()]], 'delete'),
    wkmap('bn', [[bnext]],                       'next'),
    wkmap('bp', [[bprevious]],                   'previous'),
    wkmap('b<leader>', [[bnext]],                'next'),

    {'d', group = 'code dx', desc = 'code dx'},
    wkmap('dd', [[lua Snacks.picker.diagnostics()]],              'browse'),
    wkmap('dn', [[lua vim.diagnostic.goto_next({float = true})]], 'next'),
    wkmap('dp', [[lua vim.diagnostic.goto_prev({float = true})]], 'previous'),

    {'f',  group = 'find', desc = 'find'},
    wkmap('fb', [[lua Snacks.picker.buffers()]],         'buffers'),
    wkmap('fB', [[lua Snacks.picker.grep_buffers()]],    'grep open buffers'),
    wkmap('fc', [[lua Snacks.picker.commands()]],        'commands'),
    wkmap('fd', [[lua Snacks.picker.diagnostics()]],     'diagnostic'),
    wkmap('fe', [[lua Snacks.explorer()]],               'explorer'),
    wkmap('ff', [[lua Snacks.picker.smart()]],           'files (smart)'),
    wkmap('fg', [[lua Snacks.picker.grep()]],            'grep'),
    wkmap('fh', [[lua Snacks.picker.help()]],            'help'),
    wkmap('fi', [[lua Snacks.picker.icons()]],           'icons'),
    wkmap('fk', [[lua Snacks.picker.keymaps()]],         'keymaps'),
    wkmap('ff', [[lua AW.filebrowser()]],                'files'),
    wkmap('fl', [[lua Snacks.picker.lines()]],           'local buffer'),
    wkmap('fm', [[lua Snacks.picker.marks()]],           'marks'),
    wkmap('fn', [[lua Snacks.picker.man()]],             'manpages'),
    wkmap('fs', [[lua Snacks.picker.spelling()]],        'spelling'),
    wkmap('fx', [[lua Snacks.picker.command_history()]], 'command history'),
    wkmap('fy', [[lua Snacks.picker.search_history()]],  'search history'),

    {'fi', group = 'git', desc = 'git'},
    wkmap('fib', [[lua Snacks.picker.git_branches()]], 'branches'),
    wkmap('fic', [[lua Snacks.picker.git_log()]],      'commits'),
    wkmap('fis', [[lua Snacks.picker.git_status()]],   'status'),

    {'g', group = 'goto (LSP)', desc = 'goto (LSP)'},
    wkmap('gd', [[lua Snacks.picker.lsp_definitions()]], 'definition'),
    wkmap('gr', [[lua Snacks.picker.lsp_references()]],  'references'),
    wkmap('gs', [[lua Snacks.picker.lsp_symbols()]],     'symbols'),

    {'K', group = 'make', desc = 'make'},
    wkmap('Km', [[TermExec cmd="mm"]],      'all'),
    wkmap('Kt', [[TermExec cmd="mm test"]], 'test'),

    {'o', group = 'fold', desc = 'fold'},
    wkmap('oc', 'zc', 'close'),
    wkmap('oC', 'zM', 'close all'),
    wkmap('oo', 'zo', 'open'),
    wkmap('oO', 'zR', 'open all'),
    wkmap('o<leader>', 'za', 'toggle'),

    {'p', group = 'settings', desc = 'settings'},
}

-- Gitsigns sets keymaps via a callback
function AW.maps.gitsigns(bufnr)
    map('n', '[c', cmd[[lua require('gitsigns').prev_hunk()]], {buffer = bufnr, desc = 'previous git hunk'})
    map('n', ']c', cmd[[lua require('gitsigns').next_hunk()]], {buffer = bufnr, desc = 'next git hunk'})
end
