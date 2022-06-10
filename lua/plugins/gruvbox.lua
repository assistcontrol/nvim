vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold   = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_show_eob = 0
vim.o.background = 'dark'

vim.cmd('colo gruvbox-material')

-- Override some colors
AW.defer [[
    hi clear SignColumn    " Make it the same background colour
    hi! link Folded        CustomMedium
    hi! link FoldColumn    CustomMedium
    hi! link Visual        CustomHighlight
    hi! link WinSeparator  CustomInactiveWindow
]]
