-- Key mappings
local map = require('util').map

local function base()
    -- Leader is space
    vim.g.mapleader = ' '

    -- Mash j and k, or jj/kk in place of ESC
    map('i', 'jk', '<Esc>')
    map('i', 'kj', '<Esc>')
    -- Sometimes it comes out as jj or kk
    map('i', 'jj', '<Esc>')
    map('i', 'kk', '<Esc>')

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

    -- Leader-b{b/n/p} alternates buffers
    map('n', '<Leader>bb', ':b#<CR>')
    map('n', '<Leader>bn', ':bnext<CR>')
    map('n', '<Leader>bp', ':bprevious<CR>')
    map('n', '<Leader>b',  ':b#<CR>')

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

local function bufremove()
    map('n', '<Leader>bd', '[[:lua MiniBufremove.delete()<CR>]]')
end

local function gitsigns(bufnr)
    local opts = {buffer = bufnr}
    map('n', '[c', function() require('gitsigns').prev_hunk() end, opts)
    map('n', ']c', function() require('gitsigns').next_hunk() end, opts)
end

local function surround()
    -- S surrounds visual region
    map('x', 'S', [[:lua MiniSurround.add('visual')<CR>]])
end

local function telescope()
    --  ^\ opens buffer list
    map('', '<C-\\>', function() require('telescope.builtin').buffers() end)

    -- ^P opens fuzzy finder
    map('', '<C-p>', function() require('util').filebrowser() end)

    -- ^T opens full telescope browser
    map('', '<C-t>', function() require('telescope.builtin').builtin() end)
end

return {
    setup     = base,
    bufremove = bufremove,
    gitsigns  = gitsigns,
    surround  = surround,
    telescope = telescope
}
