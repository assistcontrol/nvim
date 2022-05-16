vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold   = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_show_eob = 0
vim.o.background = 'dark'

vim.cmd('colo gruvbox-material')

-- Override some colors
require('util').on_load([[
    hi clear      SignColumn
    hi Folded     guibg=gray30
    hi FoldColumn guibg=gray30 guifg=white
    hi NonText    guifg=#4a4a59
    hi SpecialKey guifg=#4a4a59
    hi Visual     ctermfg=235 ctermbg=114 guifg=#282C34 guibg=#98C379
]])
