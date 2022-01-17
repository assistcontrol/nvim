-- Key mappings

local map = function(mode, keys, cmd, opts)
    opts = vim.tbl_deep_extend('force', {noremap = true, silent = true}, opts or {})
    vim.api.nvim_set_keymap(mode, keys, cmd, opts)
end

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

-- ^P opens fuzzy finder
map('', '<C-p>', [[:lua require('telescope.builtin').find_files()<CR>]])

-- ^T opens full telescope browser
map('', '<C-t>', ':Telescope<CR>')

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
