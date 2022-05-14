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
    on_attach = require('mapping').gitsigns
}
