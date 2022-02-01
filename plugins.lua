-- Auto-install packer.nvim
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    os.execute('git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd('packadd packer.nvim')
-- Auto-compile when this file changes
-- vim.cmd('autocmd BufWritePost plugins.lua PackerSync')

require('packer').startup({function(use)
    -- Let packer manage itself
    use {'wbthomason/packer.nvim', opt = true}

    -- mini.nvim package
    use {'echasnovski/mini.nvim', config = function()
        -- Completion
        require('plugins/completion')

        -- Comments (gc[c])
        require('mini.comment').setup()

        -- Word highlighting
        require('mini.cursorword').setup()
    end}

    -- Colorscheme
    use {'sainnhe/gruvbox-material', config = function()
        require('plugins/gruvbox')
    end}

    -- Emacs bindings
    use {'tpope/vim-rsi', config = function()
        vim.g.rsi_no_meta = true
    end}

    -- Fold preview
    use{'anuvyklack/pretty-fold.nvim', config = function()
        require('pretty-fold').setup()
        require('pretty-fold.preview').setup()
    end}

    -- Fuzzy Finder
    use {'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'}
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

    -- HTML macros
    use {'mattn/emmet-vim', ft = {'html', 'gohtmltmpl', 'ruby', 'eruby'}}

    -- Icons
    use {'kyazdani42/nvim-web-devicons', config = function()
        require('nvim-web-devicons').setup {default = true}
    end}

    -- Indentation
    use {'tpope/vim-sleuth'}

    -- Indent guides
    use {'lukas-reineke/indent-blankline.nvim', config = function()
        require('indent_blankline').setup {
            filetype_exclude = {'alpha', 'dashboard', 'startify'}
        }
    end}

    -- Loop closure (automatic brace/braket closure)
    use {'windwp/nvim-autopairs', config = function()
        require('plugins/autopairs')
    end}

    -- LSP
    use {'neovim/nvim-lspconfig'}

    -- Parentheses colors
    use {'p00f/nvim-ts-rainbow'}

    -- Start screen
    use {'goolord/alpha-nvim', config = function()
        require('plugins/alpha')
    end}

    -- Status line
    use {'ojroques/nvim-hardline', config = function()
        require('plugins/hardline')
    end}

    -- Surround text (quotes, brackets, etc.), eg: ysW"
    use {'tpope/vim-surround'}  -- Change surrounders
    use {'wellle/targets.vim'}  -- Change within surrounders

    -- Tab out
    use {'abecodes/tabout.nvim',
        requires = {'nvim-treesitter/nvim-treesitter'},
        config = function()
            require('tabout').setup {
                act_as_shift_tab = true
            }
        end
    }
    -- Tree-sitter
    use {'nvim-treesitter/nvim-treesitter', config = function()
        require('plugins/treesitter')
    end}
end,
-- Packer config
config = {
    display = {
        keybindings = {
            toggle_info = 'I',
            diff = '<CR>'
        }
    }
}})
