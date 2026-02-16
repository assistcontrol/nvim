_G.AW = {
    colorscheme = 'catppuccin-mocha'
}

require('aw/icons')
require('aw/functions')
require('aw/colors')
require('aw/general')
require('aw/keymap')
require('aw/filetypes')
require('aw/lazy')

local _, ok = pcall(vim.cmd.colorscheme, AW.colorscheme)

AW.autocmd('User', 'VeryLazy', function()
    require('aw/winbar')

    if not ok or not vim.g.colors_name then
        vim.cmd.colorscheme('elflord')
    end
end)
