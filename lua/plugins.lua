-- Auto-install packer.nvim
local packer_git = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_git)) > 0 and vim.fn.input('Download packer? [Y/n]: ') ~= 'n' then
    vim.fn.system {'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_git}
end

vim.cmd('packadd packer.nvim')
-- Auto-compile when this file changes
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

require('packer').startup({function(use)
    -- Let packer manage itself
    use {'wbthomason/packer.nvim', opt = true}

    -- mini.nvim package
    use {'echasnovski/mini.nvim', config = function()
        -- Buffer deletion
        require('mini.bufremove').setup {}

        -- Completion
        require('mini.completion').setup {}

        -- Comments (gc[c])
        require('mini.comment').setup {}

        -- Start screen
        require('plugins/ministarter')

        -- Status line
        require('plugins/ministatusline')

        -- Surrounders (cs, ysW, etc.)
        require('plugins/minisurround')

        -- Tab line
        require('plugins/minitabline')
    end}

    -- Colorscheme
    use {'sainnhe/gruvbox-material', config = function()
        require('plugins/gruvbox')
    end}

    -- Emacs bindings
    use {'linty-org/readline.nvim'}

    -- Fuzzy Finder
    use {'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('plugins/telescope')
        end
    }

    -- Git
    use {'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('plugins/gitsigns')
        end
    }

    -- Go
    use {'ray-x/go.nvim',
        ft = {'go', 'gohtmltmpl', 'gomod'},
        cmd = {'GoInstallBinaries', 'GoUpdateBinaries'},
        config = function()
            require('plugins/go')
        end
    }

    -- Help
    use {'folke/which-key.nvim', config = function()
        require('plugins/whichkey')
    end}

    -- Icons
    use {'kyazdani42/nvim-web-devicons', config = function()
        require('nvim-web-devicons').setup {default = true}
    end}

    -- Indentation
    use {'tpope/vim-sleuth'}

    -- Indent guides
    use {'lukas-reineke/indent-blankline.nvim', config = function()
        require('plugins/indentblankline')
    end}

    -- Loop closure (automatic brace/bracket closure)
    use {'windwp/nvim-autopairs', config = function()
        require('plugins/autopairs')
    end}

    -- LSP
    use {'neovim/nvim-lspconfig', config = function()
        require('plugins/lsp')
    end}

    -- Parentheses colors
    use {'p00f/nvim-ts-rainbow'}

    -- Surrounds - Change surround contents
    use {'wellle/targets.vim'}

    -- Tab out
    use {'abecodes/tabout.nvim',
        requires = {'nvim-treesitter/nvim-treesitter'},
        config = function()
            require('tabout').setup {
                act_as_shift_tab = true
            }
        end
    }

    -- Terminal
    use {'akinsho/toggleterm.nvim', config = function()
        require('plugins/toggleterm')
    end}

    -- Tree-sitter
    use {'nvim-treesitter/nvim-treesitter', config = function()
        require('plugins/treesitter')
    end}
    use {'nvim-treesitter/nvim-treesitter-textobjects',
        requires = {'nvim-treesitter/nvim-treesitter'}
    }

    -- Window management
    use {'beauwilliams/focus.nvim', config = function()
        require('focus').setup {}
    end}

    use {'https://gitlab.com/yorickpeterse/nvim-window', config = function()
        require('nvim-window').setup {
            border    = 'none',
            normal_hl = 'CustomBright'
        }
    end}
end,

-- Packer config
config = {
    autoremove = true,  -- Auto-remove disabled/unused plugins
    display = {
        keybindings = {
            toggle_info = 'I',
            diff = '<CR>'
        },
        open_fn = function()
            return require('packer.util').float({border = AW.ui.border})
        end
    }
}})
