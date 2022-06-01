-- Key mappings
AW.maps = {}

local map = AW.map

-- Leader is space
vim.g.mapleader = ' '

-- Mash j and k, or jj/kk in place of ESC
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
-- Sometimes it comes out as jj or kk
map('i', 'jj', '<Esc>')
map('i', 'kk', '<Esc>')

-- Move normally onto wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Alt-J/K jumps tabs
map('n', '<A-j>', ':tabprevious<CR>')
map('n', '<A-k>', ':tabnext<CR>')

-- ^J/^K jumps buffers
map('n', '<C-j>', ':bnext<CR>')
map('n', '<C-k>', ':bprevious<CR>')

-- Search using proper regexes by default
map('n', '/', [[/\v]])
map('n', '?', [[?\v]])

-- Tab/S-Tab through completion list
map('i', '<Tab>',   [[pumvisible() ? '<C-n>' : '<Tab>']],   {expr = true})
map('i', '<S-Tab>', [[pumvisible() ? '<C-n>' : '<S-Tab>']], {expr = true})

-- S surrounds visual region
map('x', 'S', [[:lua MiniSurround.add('visual')<CR>]])

-- ^\ saves
map({'i', 'n'}, '<C-\\>', '<cmd>write<CR>')

-- Readline-esque keys for insert and command modes
local has_readline, readline = pcall(require, 'readline')
if has_readline then
    map('!', '<C-a>', readline.beginning_of_line)
    map('!', '<C-e>', readline.end_of_line)
    map('!', '<C-w>', readline.backward_kill_word)
    map('!', '<C-k>', readline.kill_line)
    map('!', '<C-u>', function() readline.end_of_line(); readline.backward_kill_line() end)
end

AW.maps.leader = {
    -- In which-key.nvim format
    k = {':wincmd k<CR>', 'window up'},
    j = {':wincmd j<CR>', 'window down'},
    h = {':wincmd h<CR>', 'window left'},
    l = {':wincmd l<CR>', 'window right'},

    ['<leader>'] = {':b#<CR>',          'alternate'},
    e = {[[:lua AW.filebrowser()<CR>]], 'browse'},
    w = {':wincmd w<CR>',               'next window'},
    x = {':ToggleTerm<CR>',             'terminal'},
    z = {[[:lua require('mini.misc').zoom()<CR>]], 'zoom'},

    b = {
        name = 'buffer',
        b = {[[:Telescope buffers<CR>]],          'list'},
        d = {[[:lua MiniBufremove.delete()<CR>]], 'delete'},
        n = {':bnext<CR>',                        'next'},
        p = {':bprevious<CR>',                    'previous'},
        ['<leader>'] = {':bnext<CR>',             'next'},
    },

    d = {
        name = 'code dx',
        n = {[[:lua vim.diagnostic.goto_next({float = true})<CR>]], 'next'},
        p = {[[:lua vim.diagnostic.goto_prev({float = true})<CR>]], 'previous'},
    },

    f = {
        name = 'find',
        b = {[[:Telescope buffers<CR>]],     'buffers'},
        d = {[[:Telescope diagnostics<CR>]], 'diagnostics'},
        e = {':Explore<CR>',                 'explorer'},
        t = {[[:Telescope<CR>]],             'telescope'},
        f = {[[:lua AW.filebrowser()<CR>]], 'files'}
    },

    m = {
        -- alias mm='make -j$(sysctl -n hw.ncpu)'
        name = 'make',
        m = {[[:TermExec cmd="mm"<CR>]],      'all'},
        t = {[[:TermExec cmd="mm test"<CR>]], 'test'}
    }
}

-- Gitsigns sets keymaps via a callback
function AW.maps.gitsigns(bufnr)
    local opts = {buffer = bufnr}
    map('n', '[c', function() require('gitsigns').prev_hunk() end, opts)
    map('n', ']c', function() require('gitsigns').next_hunk() end, opts)
end

