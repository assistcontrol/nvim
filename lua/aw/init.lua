pcall(require, 'impatient')   -- Keep this at the very top

_G.AW = {}

require('aw/functions')
require('aw/colors')
require('aw/general')
require('aw/plugins')

if not vim.g.colors_name then
    vim.cmd('colorscheme elflord')
end

require('aw/filetypes')
require('aw/mapping')
