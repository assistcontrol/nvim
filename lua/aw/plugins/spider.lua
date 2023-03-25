return {
    'chrisgrieser/nvim-spider',
    event = {'BufReadPre', 'BufNewFile'},
    config = function()
        local spider = require('spider')
        local map = function(motion, desc)
            vim.keymap.set({'n', 'o', 'x'}, motion, function() spider.motion(motion) end, { desc = desc })
        end

        map('w',  'next word (Spider)')
        map('e',  'end of word (Spider)')
        map('b',  'prev word (Spider)')
        map('ge', 'end of prev  word (Spider)')
    end
}
