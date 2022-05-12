-- Key mappings
local map = require('util').map

-- Mash j and k, or jj/kk in place of ESC
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
-- Sometimes those maps are interpreted as a double-tap
map('i', 'jj', '<Esc>')
map('i', 'kk', '<Esc>')

-- Move normally onto wrapped lines
map('', 'j', 'gj')
map('', 'k', 'gk')

-- ^L mutes search highlighting in normal mode
map('n', '<C-l>', ':<C-u>nohlsearch<CR><C-l>')
-- ^L corrects last misspelled word in insert mode
map('i', '<C-l>', [[<c-g>u<Esc>[s1z=`]a<c-g>u]])

-- ^O opens file browser
map('', '<C-o>', ':Explore<CR>')

-- ]t/[t jumps tabs
map('n', '[t', ':tabprevious<CR>')
map('n', ']t', ':tabnext<CR>')

-- ]b/[b jumps buffers
map('n', '[b', ':bprevious<CR>')
map('n', ']b', ':bnext<CR>')

-- Search using proper regexes by default
map('n', '/', [[/\v]])
map('n', '?', [[?\v]])

-- Tab/S-Tab through completion list
map('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   {expr = true})
map('i', '<S-Tab>', [[pumvisible() ? "\<C-n>" : "\<S-Tab>"]], {expr = true})
