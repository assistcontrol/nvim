-- Define some colour groups that plugins can link to
vim.api.nvim_create_autocmd('VimEnter', { callback = function()
    vim.api.nvim_exec([[
        hi CustomBright      ctermfg=235 ctermbg=114 guifg=#282C34 guibg=#98C379
        hi CustomMedium      ctermfg=145 ctermbg=237 guifg=#ABB2BF guibg=#3E4452
        hi CustomSoft        ctermfg=180 ctermbg=236 guifg=#E5C07B guibg=#2C323C

        hi CustomModeInsert  ctermfg=235 ctermbg=39  guifg=#282C34 guibg=#61AFEF
        hi CustomModeVisual  ctermfg=235 ctermbg=170 guifg=#282C34 guibg=#C678DD
        hi CustomModeReplace ctermfg=235 ctermbg=38  guifg=#282C34 guibg=#56B6C2
        hi CustomModeCommand ctermfg=235 ctermbg=204 guifg=#282C34 guibg=#E06C75

        hi CustomError       ctermfg=235 ctermbg=204 guifg=#282C34 guibg=#E06C75
        hi CustomWarning     ctermfg=235 ctermbg=180 guifg=#282C34 guibg=#E5C07B
        hi CustomBrightError ctermfg=204 ctermbg=114 guifg=#E06C75 guibg=#98C379
        hi CustomMediumError ctermfg=204 ctermbg=237 guifg=#E06C75 guibg=#3E4452
    ]], false)
end })
