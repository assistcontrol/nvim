vim.cmd('colo elflord')  -- Overridden later

AW = {}

require('util')
require('colors').setup()
require('plugins')
require('general')
require('mapping').setup()
require('filetypes')
