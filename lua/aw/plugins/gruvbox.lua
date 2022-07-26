vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold   = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_show_eob = 0
vim.opt.background = 'dark'

vim.cmd('colo gruvbox-material')

-- Override some colors
AW.colorcmd.register [[
    hi clear SignColumn    " Make it the same background colour
    hi! link Folded        CustomMedium
    hi! link FoldColumn    CustomMedium
    hi! link MatchParen    CustomError
    hi! link Visual        CustomHighlight
]]
