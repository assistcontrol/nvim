return {
    'saghen/blink.pairs',
    dependencies = 'saghen/blink.lib',

    enabled = not AW.is_root() and not vim.g.vscode,
    event = {'BufReadPre', 'BufNewFile'},

    build = function() require('blink.pairs').build():pwait(60000) end,
    config = function()
        local ok, pairs = pcall(require, 'blink.pairs')
        if not ok then return vim.notify('blink.pairs failed to start') end
        pairs.setup {
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
        }
    end,
}
