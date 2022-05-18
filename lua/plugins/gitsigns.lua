-- foo => hl=GitSignsFoo, numhl=GitSignsFooNr, linehl=GitSignsFooLn
local function highlightTable(ico, class)
    class = 'GitSigns' .. class
    return {text = ico, hl = class, numhl = class .. 'Nr', linehl = class .. 'Ln'}
end

require('gitsigns').setup {
    signs = {
        add          = highlightTable(AW.icon('add'),     'Add'),
        change       = highlightTable(AW.icon('vertbar'), 'Change'),
        delete       = highlightTable(AW.icon('delete'),  'Delete'),
        topdelete    = highlightTable(AW.icon('delete'),  'Delete'),
        changedelete = highlightTable(AW.icon('delete'),  'Change')
    },
    watch_gitdir = {interval = 300, follow_files = true},
    on_attach = AW.maps.gitsigns
}
