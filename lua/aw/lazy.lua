local lazy = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

local need_lazy = function()
    if vim.loop.fs_stat(lazy) then return false end
    if vim.fn.input('Download lazy? [Y/n]: ') == 'n' then return false end

    return true
end

if need_lazy() then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable',
        lazy
    })
end
vim.opt.rtp:prepend(lazy)

AW.deps = {
    devicons   = 'nvim-tree/nvim-web-devicons',
    mini       = 'echasnovski/mini.nvim',
    nui        = 'muniftanjim/nui.nvim',
    plenary    = 'nvim-lua/plenary.nvim',
    treesitter = 'nvim-treesitter/nvim-treesitter'
}

require('lazy').setup('aw.plugins', {
    performance = {
        rtp = {
            paths = {AW_MODULE_PATH}
        }
    }
})
