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
    }
}

vim.cmd('colorscheme catppuccin')

AW.colorcmd.register [[
    hi! link MatchParen   CustomError
]]
