vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold   = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_show_eob = 0
vim.opt.background = 'dark'

vim.cmd('colo gruvbox-material')

-- Override some colors
AW.colorcmd.register [[
    " Override some colors
    hi clear SignColumn    " Make it the same background colour
    hi! link Folded        CustomMedium
    hi! link FoldColumn    CustomMedium
    hi! link MatchParen    CustomError
    hi! link Visual        CustomHighlight

    hi! link MiniStatuslineModeNormal  CustomBright
    hi! link MiniStatuslineModeInsert  CustomModeInsert
    hi! link MiniStatuslineModeVisual  CustomModeVisual
    hi! link MiniStatuslineModeReplace CustomModeReplace
    hi! link MiniStatuslineModeCommand CustomModeCommand

    hi! link MiniTablineCurrent         CustomBright
    hi! link MiniTablineVisible         CustomMedium
    hi! link MiniTablineHidden          CustomSoft
    hi! link MiniTablineModifiedCurrent CustomBright
    hi! link MiniTablineModifiedVisible CustomMedium
    hi! link MiniTablineModifiedHidden  CustomMediumError
    hi! link MiniTablineTabpagesection  CustomSoft

    hi! link NeoTreeFloatBorder Normal
    hi! link NeoTreeFloatTitle  CustomBright

    hi! link TelescopeBorder NormalFloat
    hi! link TelescopeNormal NormalFloat
    hi! link TelescopePromptPrefix NormalFloat
    hi! link TelescopePromptCounter  NormalFloat
    hi! link TelescopeSelection CustomHighlight

    hi! link WhichKeyFloat CustomMedium
]]
