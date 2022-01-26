local icon = require('util').icon

-- foo => hl=GitSignsFoo, numhl=GitSignsFooNr, linehl=GitSignsFooLn
local function highlightTable(ico, class)
    class = 'GitSigns' .. class
    return {text = ico, hl = class, numhl = class .. 'Nr', linehl = class .. 'Ln'}
end

require('gitsigns').setup {
    signs = {
        add          = highlightTable(icon('add'),     'Add'),
        change       = highlightTable(icon('vertbar'), 'Change'),
        delete       = highlightTable(icon('delete'),  'Delete'),
        topdelete    = highlightTable(icon('delete'),  'Delete'),
        changedelete = highlightTable(icon('delete'),  'Change')
    },
    watch_gitdir = {interval = 300, follow_files = true},
    on_attach = function(bufnr)
        local opts = {expr = true}
        vim.api.nvim_buf_set_keymap(bufnr, 'n', ']c', [[&diff ? 'lc' : '<cmd>lua require("gitsigns.actions").next_hunk()<CR>']], opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '[c', [[&diff ? 'lc' : '<cmd>lua require("gitsigns.actions").prev_hunk()<CR>']], opts)
    end
}
