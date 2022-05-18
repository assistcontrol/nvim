local colors = {
    fg = {
        beige     = [[ctermfg=223 guifg=#D4BE98]],
        darkgray  = [[ctermfg=235 guifg=#282C34]],
        lightgray = [[ctermfg=145 guifg=#ABB2BF]],
        red       = [[ctermfg=204 guifg=#E06C75]],
        yellow    = [[ctermfg=180 guifg=#E5C07B]]
    },
    bg = {
        darkgray   = [[ctermbg=236 guibg=#2C323C]],
        green      = [[ctermbg=114 guibg=#98C379]],
        mediumgray = [[ctermbg=237 guibg=#3E4452]],
        paleblue   = [[ctermbg=39  guibg=#61AFEF]],
        palegreen  = [[ctermbg=38  guibg=#56B6C2]],
        purple     = [[ctermbg=170 guibg=#C678DD]],
        red        = [[ctermbg=204 guibg=#E06C75]],
        yellow     = [[ctermbg=180 guibg=#E5C07B]],
    }
}

function AW.highlight(color_table, other_commands)
    local hi = ''
    for group, colordef in pairs(color_table) do
        hi = hi .. string.format("hi %s %s %s\n", group, colors.fg[colordef[1]] or '', colors.bg[colordef[2]] or '')
    end
    hi = hi .. (other_commands or '')
    AW.on_load(hi)
end

return {
    border = 'solid',
    borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    setup = function()
        AW.highlight({
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
        }, [[
            hi link CustomHighlight CustomBright
        ]])
    end
}
