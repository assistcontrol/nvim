vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold   = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_show_eob = 0
vim.opt.background = 'dark'

vim.cmd('colo gruvbox-material')

-- Colors set in the C table are composed below into highlight strings
-- Each value is {termcolor, rgbcolor}
local C = {
    beige      = {223, '#D4BE98'},
    darkergray = {235, '#282C34'},
    darkgray   = {236, '#32302F'},
    green      = {114, '#98C379'},
    lightgray  = {145, '#ABB2BF'},
    mediumgray = {237, '#3E4452'},
    normalback = {235, '#282828'},
    paleblue   = {39,  '#61AFEF'},
    palegreen  = {38,  '#56B6C2'},
    purple     = {170, '#C678DD'},
    red        = {204, '#E06C75'},
    softgray   = {237, '#3C3836'},
    yellow     = {180, '#E5C07B'},
}

local function bg(color)
    return string.format('ctermbg=%s guibg=%s', color[1] or '', color[2] or '')
end

local function fg(color)
    return string.format('ctermfg=%s guifg=%s', color[1] or '', color[2] or '')
end

-- Set up highlighting groups that end groups can link to
local highlights = {
    CustomBright       = {fg(C.darkergray),  bg(C.green)},
    CustomMediumBright = {fg(C.beige),       bg(C.mediumgray)},
    CustomMedium       = {fg(C.lightgray),   bg(C.mediumgray)},
    CustomSoft         = {fg(C.yellow),      bg(C.darkgray)},

    CustomModeInsert   = {fg(C.darkergray),  bg(C.paleblue)},
    CustomModeVisual   = {fg(C.darkergray),  bg(C.purple)},
    CustomModeReplace  = {fg(C.darkergray),  bg(C.palegreen)},
    CustomModeCommand  = {fg(C.darkergray),  bg(C.red)},

    CustomError        = {fg(C.darkergray),  bg(C.red)},
    CustomWarning      = {fg(C.darkergray),  bg(C.yellow)},
    CustomBrightError  = {fg(C.red),         bg(C.green)},
    CustomMediumError  = {fg(C.red),         bg(C.mediumgray)},

    CustomMediumBrightBlank = {fg(C.mediumgray), bg(C.mediumgray)},
}

for group, colors in pairs(highlights) do
    local cmd = string.format('hi %s %s %s', group, colors[1], colors[2])
    AW.colorcmd.register(cmd)
end

-- Override some colors
AW.colorcmd.register [[
    hi  link CustomHighlight CustomBright
    hi! link NormalFloat CustomMedium
    hi! link FloatBorder CustomMedium
    hi WinBar   ctermfg=white guifg=white cterm=bold gui=bold
    hi WinBarNC ctermfg=white guifg=white

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
