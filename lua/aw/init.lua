_G.AW = {}

require('aw/icons')
require('aw/functions')
require('aw/colors')
require('aw/general')
require('aw/winbar')
require('aw/mapping')
require('aw/lazy')
require('aw/filetypes')

if not vim.g.colors_name then
    vim.cmd('colorscheme elflord')
end
