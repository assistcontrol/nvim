AW.ui = {
    border = 'solid',
    borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    winblend = vim.fn.has('gui_running') > 0 and 8 or 0
}

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

local function highlight(color_table, other_commands)
    local hi = ''
    for group, colors in pairs(color_table) do
        hi = hi .. string.format("hi %s %s %s\n", group, colors[1], colors[2])
    end
    hi = hi .. (other_commands or '')
    AW.colorcmd(hi)
end

-- Set up highlighting groups that end groups can link to
highlight({
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

    CustomActiveWindow      = {'',               bg(C.normalback)},
    CustomInactiveWindow    = {'',               bg(C.softgray)},

    CustomMediumBrightBlank = {fg(C.mediumgray), bg(C.mediumgray)},
    CustomInactiveBlank     = {fg(C.softgray),   bg(C.softgray)},
}, [[
    hi  link CustomHighlight CustomBright
    hi! link NormalFloat Normal
    hi! link FloatBorder Normal
]])
