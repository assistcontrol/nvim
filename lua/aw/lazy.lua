local colorscheme = 'catppuccin'

local lazy = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if (not vim.loop.fs_stat(lazy)) and vim.fn.input('Download lazy? [Y/n]: ') ~= 'n' then
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable',
        'https://github.com/folke/lazy.nvim.git', lazy
    })
end
vim.opt.rtp:prepend(lazy)

AW.deps = {
    lspconfig  = 'neovim/nvim-lspconfig',
    mini       = 'nvim-mini/mini.nvim',
    nui        = 'muniftanjim/nui.nvim',
    plenary    = 'nvim-lua/plenary.nvim',
    treesitter = 'nvim-treesitter/nvim-treesitter'
}

require('lazy').setup('aw.plugins', {
    change_detection = {
        enabled = false,
    },
    colorscheme = colorscheme,
    git = {
        timeout = 300,
    },
    install = {
        colorscheme = {colorscheme},
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'netrwPlugin',
                'tutor',
            },
            paths = {AW_MODULE_PATH},
        },
    },
    rocks = {
        enabled = false,
    },
    ui = {
        custom_keys = {
            ["<localleader>l"] = false,
            T = {
                vim.cmd.TSUpdate,
                desc = 'TSUpdate',
            },
        },
    },
})
