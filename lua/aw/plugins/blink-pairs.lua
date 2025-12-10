return {
    'saghen/blink.pairs',
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
