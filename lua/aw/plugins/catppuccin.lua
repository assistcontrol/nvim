if not AW.has('catppuccin') then return end

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
        telescope = true,
        treesitter = true,
        ts_rainbow = true,
        which_key = true,

        indent_blankline = {
            enabled = true
        },
        native_lsp = {
            enabled = true
        }
    },
    custom_highlights = function(colors)
        return {
            MatchParen = {fg=colors.mantle, bg=colors.red},

            TelescopeBorder = {bg=colors.crust},
            TelescopeNormal = {bg=colors.crust},
            TelescopePromptPrefix  = {bg=colors.crust},
            TelescopePromptCounter = {bg=colors.crust},

            WinBar   = {fg='white', style={'bold'}},
            WinBarNC = {fg='white'},

            CustomError   = {fg=colors.mantle, bg=colors.red},
            CustomWarning = {fg=colors.mantle, bg=colors.yellow},
            CustomBlank   = {fg=colors.mantle,   bg=colors.mantle},
        }
    end
}

vim.cmd('colorscheme catppuccin')

-- Palette:
-- 	flamingo:  "#F2CDCD", blue:   "#89B4FA", green: "#A6E3A1",
-- 	lavender:  "#B4BEFE", maroon: "#EBA0AC", mauve: "#CBA6F7",
-- 	rosewater: "#F5E0DC", peach:  "#FAB387", pink:  "#F5C2E7",
-- 	sapphire:  "#74C7EC", red:    "#F38BA8", sky:   "#89DCEB",
-- 	yellow:    "#F9E2AF", teal:   "#94E2D5",
-- 	text: "#CDD6F4", subtext1: "#BAC2DE", subtext0: "#A6ADC8",
-- 	overlay2: "#9399B2", overlay1: "#7F849C", overlay0: "#6C7086",
-- 	surface2: "#585B70", surface1: "#45475A", surface0: "#313244",
-- 	base: "#1E1E2E", mantle: "#181825", crust: "#11111B",
