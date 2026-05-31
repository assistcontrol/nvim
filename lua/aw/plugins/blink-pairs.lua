return {
    'saghen/blink.pairs',
    dependencies = 'saghen/blink.lib',

    enabled = not AW.is_root() and not vim.g.vscode,
    build = function() require('blink.pairs').build():pwait(60000) end,
    opts = {
        highlights = {
            groups = {
                'BlinkPairsCyan',
                'BlinkPairsPurple',
                'BlinkPairsGreen',
                'BlinkPairsOrange',
                'BlinkPairsBlue',
                'BlinkPairsYellow',
            },

            matchparen = {
                include_surrounding = true,
            },
        },
    },
}
