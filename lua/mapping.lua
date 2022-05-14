-- Key mappings
local map = require('util').map

local function base()
    -- Leader is space
    vim.g.mapleader = ' '

    -- Mash j and k, or jj/kk in place of ESC
    map('i', 'jk', '<Esc>')
    map('i', 'kj', '<Esc>')

    -- Move normally onto wrapped lines
    map('', 'j', 'gj')
    map('', 'k', 'gk')

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

    -- <Leader>+HJKL navigates windows
    map('n', '<Leader>k', ':wincmd k<CR>')
    map('n', '<Leader>j', ':wincmd j<CR>')
    map('n', '<Leader>h', ':wincmd h<CR>')
    map('n', '<Leader>l', ':wincmd l<CR>')
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
    map('', '<C-t>', [[:lua require('telescope.builtin').builtin()<CR>]])
end

return {
    base = base,
    gitsigns = gitsigns,
    telescope = telescope
}
