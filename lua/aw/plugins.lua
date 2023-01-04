-- vim: ts=4 sw=4
-- Auto-install packer.nvim
local packer_git = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_git)) > 0 and vim.fn.input('Download packer? [Y/n]: ') ~= 'n' then
    vim.fn.system {'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_git}
end

vim.cmd('packadd packer.nvim')
-- Auto-compile when this file changes
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

require('packer').startup({function(use)
    local deps = {
        devicons   = 'nvim-tree/nvim-web-devicons',
        nui        = 'muniftanjim/nui.nvim',
        plenary    = 'nvim-lua/plenary.nvim',
        treesitter = 'nvim-treesitter/nvim-treesitter'
    }

    -- Are we running as root?
    local root = AW.is_root()

    -- Let packer manage itself
    use {'wbthomason/packer.nvim', opt = true}

    -- mini.nvim package
    use {'echasnovski/mini.nvim', config = function()
        -- a/i surrounders (a", i[, etc.)
        require('aw/plugins/miniai')

        -- animation
        require('mini.animate').setup {}

        -- Buffer deletion
        require('mini.bufremove').setup {}

        -- Completion
        require('mini.completion').setup {}

        -- Comments (gc[c])
        require('mini.comment').setup {}

        -- Start screen
        require('aw/plugins/ministarter')

        -- Status line
        require('aw/plugins/ministatusline')

        -- Surrounders (cs, ysW, etc.)
        require('aw/plugins/minisurround')

        -- Tab line
        require('aw/plugins/minitabline')

        -- Whitespace at EOL
        require('mini.trailspace').setup {}

        -- ch to appropriate dir
        require('mini.misc').setup {}
        MiniMisc.setup_auto_root {'.git', 'Makefile', '.root'}
    end}

    -- Color highlighting
    use {'nvchad/nvim-colorizer.lua',
        cond = not root,
        config = function()
            require('colorizer').setup {}
        end
    }

    -- Colorscheme
    use {'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('aw/plugins/catppuccin')
        end
    }

    -- Emacs bindings
    use 'linty-org/readline.nvim'

    -- Explorer
    use {'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {deps.devicons, deps.nui, deps.plenary},
        config = function()
            require('aw/plugins/neo-tree')
        end
    }

    -- Fuzzy Finder
    use {'nvim-telescope/telescope.nvim',
        requires = deps.plenary,
        config = function()
            require('aw/plugins/telescope')
        end
    }

    -- Git
    use {'lewis6991/gitsigns.nvim',
        requires = deps.plenary,
        cond = not root,
        config = function()
            require('aw/plugins/gitsigns')
        end
    }

    -- Go
    use {'ray-x/go.nvim',
        ft = {'go', 'gohtmltmpl', 'gomod'},
        cmd = {'GoInstallBinaries', 'GoUpdateBinaries'},
        cond = not root,
        config = function()
            require('aw/plugins/go')
        end
    }

    -- Help
    use {'folke/which-key.nvim', config = function()
        require('aw/plugins/whichkey')
    end}

    -- HTML
    use {'mattn/emmet-vim',
        ft = {'html', 'tt2html'},
        cond = not root,
        config = function()
            vim.g.user_emmet_settings = {
                html = {block_all_childless = true}  -- New line for all tags
            }
        end
    }
    -- Icons
    use {deps.devicons, config = function()
        require('nvim-web-devicons').setup {default = true}
    end}

    -- Indentation
    use 'Darazaki/indent-o-matic'

    -- Indent guides
    use {'lukas-reineke/indent-blankline.nvim', config = function()
        require('aw/plugins/indentblankline')
    end}

    -- Loop closure (automatic brace/bracket closure)
    use {'windwp/nvim-autopairs', config = function()
        require('aw/plugins/autopairs')
    end}

    use {'rrethy/nvim-treesitter-endwise',
        requires = deps.treesitter
    }

    -- LSP
    use {'neovim/nvim-lspconfig', config = function()
        require('aw/plugins/lsp')
    end}
    use {'j-hui/fidget.nvim', config = function()
        require('fidget').setup {
            text = {spinner = 'dots_negative'}
        }
    end}

    -- Parentheses colors
    use 'p00f/nvim-ts-rainbow'

    -- Startup hacking
    use 'lewis6991/impatient.nvim'

    -- Tab out
    use {'abecodes/tabout.nvim',
        requires = deps.treesitter,
        config = function()
            require('tabout').setup {
                act_as_shift_tab = true
            }
        end
    }

    -- Terminal
    use {'akinsho/toggleterm.nvim', config = function()
        require('aw/plugins/toggleterm')
    end}

    -- Tree-sitter
    use {'nvim-treesitter/nvim-treesitter', config = function()
        require('aw/plugins/treesitter')
    end}
    use {'nvim-treesitter/nvim-treesitter-textobjects',
        requires = deps.treesitter
    }

    -- Window management
    use {'beauwilliams/focus.nvim', config = function()
        require('aw/plugins/focus')
    end}

    use {'s1n7ax/nvim-window-picker', config = function()
        require('aw/plugins/window-picker')
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
