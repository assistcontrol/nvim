local opts = {
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

-- Just produces errors on macOS. Not sure why yet...
if AW.os('macOS') then
    return {
        'saghen/blink.pairs',
        dependencies = 'saghen/blink.lib',
        version = '*',

        enabled = not AW.is_root() and not vim.g.vscode,
        event = {'BufReadPre', 'BufNewFile'},

        opts = opts,
    }
end

return {
    'saghen/blink.pairs',
    dependencies = 'saghen/blink.lib',

    enabled = not AW.is_root() and not vim.g.vscode,
    event = {'BufReadPre', 'BufNewFile'},

    build = function() require('blink.pairs').build():pwait(60000) end,
    config = function()
        local ok, pairs = pcall(require, 'blink.pairs')
        if ok then pairs.setup(opts) end
    end,
}
