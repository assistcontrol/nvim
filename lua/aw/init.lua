_G.AW = {}

require('aw/icons')
require('aw/functions')
require('aw/colors')
require('aw/general')
require('aw/mapping')
require('aw/filetypes')
require('aw/lazy')

if not vim.g.colors_name then
    vim.cmd.colorscheme('elflord')
end

AW.autocmd('User', 'VeryLazy', function()
    require('aw/winbar')
end)
