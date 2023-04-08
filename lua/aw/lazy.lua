local lazy = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if (not vim.loop.fs_stat(lazy)) and vim.fn.input('Download lazy? [Y/n]: ') ~= 'n' then
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable',
        'https://github.com/folke/lazy.nvim.git', lazy
    })
end
vim.opt.rtp:prepend(lazy)

AW.deps = {
    devicons   = 'nvim-tree/nvim-web-devicons',
    lspconfig  = 'neovim/nvim-lspconfig',
    mini       = 'echasnovski/mini.nvim',
    navbuddy   = 'smiteshp/nvim-navbuddy',
    nui        = 'muniftanjim/nui.nvim',
    plenary    = 'nvim-lua/plenary.nvim',
    treesitter = 'nvim-treesitter/nvim-treesitter'
}

require('lazy').setup('aw.plugins', {
    colorscheme = 'catppuccin',
    performance = {
        rtp = {
            disabled_plugins = {
                'netrwPlugin',
                'tutor'
            },
            paths = {AW_MODULE_PATH}
        }
    }
})
