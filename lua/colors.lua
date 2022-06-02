AW.ui = {
    border = 'solid',
    borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    winblend = vim.fn.has('gui_running') > 0 and 8 or 0
}

local colors = {
    fg = {
        beige      = [[ctermfg=223 guifg=#D4BE98]],
        darkgray   = [[ctermfg=235 guifg=#282C34]],
        lightgray  = [[ctermfg=145 guifg=#ABB2BF]],
        mediumgray = [[ctermfg=237 guifg=#3E4452]],
        red        = [[ctermfg=204 guifg=#E06C75]],
        softgray   = [[ctermfg=237 guifg=#3C3836]],
        yellow     = [[ctermfg=180 guifg=#E5C07B]]
    },
    bg = {
        darkgray   = [[ctermbg=236 guibg=#2C323C]],
        green      = [[ctermbg=114 guibg=#98C379]],
        mediumgray = [[ctermbg=237 guibg=#3E4452]],
        normal     = [[ctermbg=235 guibg=#282828]],
        paleblue   = [[ctermbg=39  guibg=#61AFEF]],
        palegreen  = [[ctermbg=38  guibg=#56B6C2]],
        purple     = [[ctermbg=170 guibg=#C678DD]],
        red        = [[ctermbg=204 guibg=#E06C75]],
        softgray   = [[ctermbg=237 guibg=#3C3836]],
        yellow     = [[ctermbg=180 guibg=#E5C07B]],
    }
}

function AW.ui.highlight(color_table, other_commands)
    local hi = ''
    for group, colordef in pairs(color_table) do
        hi = hi .. string.format("hi %s %s %s\n", group, colors.fg[colordef[1]] or '', colors.bg[colordef[2]] or '')
    end
    hi = hi .. (other_commands or '')
    AW.defer(hi)
end

-- Set up highlighting groups that end groups can link to
AW.ui.highlight({
    CustomBright       = {'darkgray',  'green'},
    CustomMediumBright = {'beige',     'mediumgray'},
    CustomMedium       = {'lightgray', 'mediumgray'},
    CustomSoft         = {'yellow',    'darkgray'},

    CustomModeInsert   = {'darkgray',  'paleblue'},
    CustomModeVisual   = {'darkgray',  'purple'},
    CustomModeReplace  = {'darkgray',  'palegreen'},
    CustomModeCommand  = {'darkgray',  'red'},

    CustomError        = {'darkgray',  'red'},
    CustomWarning      = {'darkgray',  'yellow'},
    CustomBrightError  = {'red',       'green'},
    CustomMediumError  = {'red',       'mediumgray'},

    CustomActiveWindow   = {'',        'normal'},
    CustomInactiveWindow = {'',        'softgray'},

    CustomMediumBrightBlank = {'mediumgray', 'mediumgray'},
    CustomInactiveBlank     = {'softgray',   'softgray'}
}, [[
    hi  link CustomHighlight CustomBright
    hi! link NormalFloat Normal
    hi! link FloatBorder Normal
]])
