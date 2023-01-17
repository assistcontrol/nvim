_G.AW = {}

require('aw/icons')
require('aw/functions')
require('aw/colors')
require('aw/general')
require('aw/mapping')
require('aw/lazy')

if not vim.g.colors_name then
    vim.cmd('colorscheme elflord')
end

vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        require('aw/winbar')
        require('aw/filetypes')
    end
})
