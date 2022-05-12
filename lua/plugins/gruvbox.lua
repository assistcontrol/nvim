vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold   = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_show_eob = 0
vim.o.background = 'dark'

vim.cmd('colo gruvbox-material')

-- Override some colors
vim.cmd([[
    highlight clear      SignColumn
    highlight Folded     guibg=gray30
    highlight FoldColumn guibg=gray30 guifg=white
    highlight NonText    guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59
    highlight Visual     ctermbg=yellow ctermfg=black guibg=yellow guifg=black
]])
