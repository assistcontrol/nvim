-- Load impatient immediately so that it can cache as much as posible.
-- It's loaded in a pcall to avoid erroring if it doesn't exist yet.
pcall(require, 'impatient')

vim.cmd('colo elflord')  -- Overridden later

_G.AW = {}

require('aw/functions')
require('aw/colors')
require('aw/general')
require('aw/plugins')

require('aw/filetypes')
require('aw/mapping')
