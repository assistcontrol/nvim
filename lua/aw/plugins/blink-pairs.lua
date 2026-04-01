return {
    'saghen/blink.pairs',
    enabled = not AW.is_root() and not vim.g.vscode,
    build = 'cargo build --release',
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
        },
    },
}
