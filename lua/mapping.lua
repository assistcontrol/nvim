-- Key mappings
local map = require('util').map

local function base()
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

    -- Alt+arrow navigates windows
    map('n', '<A-Up>',    ':wincmd k<CR>')
    map('n', '<A-Down>',  ':wincmd j<CR>')
    map('n', '<A-Left>',  ':wincmd h<CR>')
    map('n', '<A-Right>', ':wincmd l<CR>')
    -- So does ^HJKL
    map('n', '<C-K>', ':wincmd k<CR>')
    map('n', '<C-J>', ':wincmd j<CR>')
    map('n', '<C-H>', ':wincmd h<CR>')
    map('n', '<C-L>', ':wincmd l<CR>')
end

local function gitsigns(bufnr)
    local opts = {buffer = bufnr}
    map('n', '[c', [[:lua require('gitsigns').prev_hunk()<CR>]], opts)
    map('n', ']c', [[:lua require('gitsigns').next_hunk()<CR>]], opts)
end

local function telescope()
    --  ^\ opens buffer list
    map('', '<C-\\>', [[:lua require('telescope.builtin').buffers()<CR>]])

    -- ^P opens fuzzy finder
    map('', '<C-p>', [[:lua require('util').filebrowser()<CR>]])

    -- ^T opens full telescope browser
    map('', '<C-t>', ':Telescope<CR>')
end

return {
    base = base,
    gitsigns = gitsigns,
    telescope = telescope
}
