return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
        require('catppuccin').setup {
            flavour = 'mocha',
            dim_inactive = {
                enabled = true
            },
            styles = {
                conditionals = {'bold'},
                loops = {'bold'},
                functions = {'bold'},
                keywords = {'bold'},
                variables = {'bold'},
                booleans = {'bold'},
            },
            integrations = {
                fidget = true,
                gitsigns = true,
                mini = true,
                neotree = true,
                treesitter = true,
                ts_rainbow = true,
                which_key = true,

                indent_blankline = {
                    enabled = true
                },
                native_lsp = {
                    enabled = true
                },
                telescope = {
                    enabled = true,
                    style = 'classic'
                }
            },
            custom_highlights = function(colors)
                return {
                    MatchParen = {fg=colors.mantle, bg=colors.blue},

                    MiniStatuslineFilename = {fg=colors.text, bg=colors.base},
                    TelescopeBorder = {bg=colors.crust},
                    TelescopeNormal = {bg=colors.crust},
                    TelescopePromptPrefix  = {bg=colors.crust},
                    TelescopePromptCounter = {bg=colors.crust},

                    WinBar   = {fg='white', style={'bold'}},
                    WinBarNC = {fg='white'},

                    CustomError   = {fg=colors.mantle, bg=colors.red},
                    CustomWarning = {fg=colors.mantle, bg=colors.yellow},
                    CustomBlank   = {fg=colors.mantle, bg=colors.mantle},
                }
            end
        }

        vim.cmd('colorscheme catppuccin')
    end
}

-- Palette:
-- | Name      |  Mocha     | Usage           |
-- | --------- |  --------- | --------------- |
-- | rosewater |  `#F5E0DC` | Winbar          |
-- | flamingo  |  `#F2CDCD` | Target word     |
-- | pink      |  `#F5C2E7` | Just pink       |
-- | mauve     |  `#CBA6F7` | Tag             |
-- | red       |  `#F38BA8` | Error           |
-- | maroon    |  `#EBA0AC` | Lighter red     |
-- | peach     |  `#FAB387` | Number          |
-- | yellow    |  `#F9E2AF` | Warning         |
-- | green     |  `#A6E3A1` | Diff add        |
-- | teal      |  `#94E2D5` | Hint            |
-- | sky       |  `#89DCEB` | Operator        |
-- | sapphire  |  `#74C7EC` | Constructor     |
-- | blue      |  `#89B4FA` | Diff changed    |
-- | lavender  |  `#B4BEFE` | CursorLine Nr   |
-- | text      |  `#CDD6F4` | Default fg      |
-- | subtext1  |  `#BAC2DE` | Indicator       |
-- | subtext0  |  `#A6ADC8` | Float title     |
-- | overlay2  |  `#9399B2` | Popup fg        |
-- | overlay1  |  `#7F849C` | Conceal color   |
-- | overlay0  |  `#6C7086` | Fold color      |
-- | surface2  |  `#585B70` | Default comment |
-- | surface1  |  `#45475A` | Darker comment  |
-- | surface0  |  `#313244` | Darkest comment |
-- | base      |  `#1E1E2E` | Default bg      |
-- | mantle    |  `#181825` | Darker bg       |
-- | crust     |  `#11111B` | Darkest bg      |
