vim.g.gruvbox_material_enable_bold   = 1
vim.g.gruvbox_material_enable_italic = 1
vim.o.background = 'dark'

vim.cmd('colo gruvbox-material')

-- Override some colors
vim.cmd([[highlight clear      SignColumn]])
vim.cmd([[highlight Folded     guibg=gray30]])
vim.cmd([[highlight FoldColumn guibg=gray30 guifg=white]])
vim.cmd([[highlight NonText    guifg=#4a4a59]])
vim.cmd([[highlight SpecialKey guifg=#4a4a59]])
