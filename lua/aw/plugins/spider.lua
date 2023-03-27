return {
    'chrisgrieser/nvim-spider',
    event = {'BufReadPre', 'BufNewFile'},
    config = function()
        local spider = require('spider').motion
        local map = function(motion, desc)
            vim.keymap.set({'n', 'o', 'x'}, motion, function() spider(motion) end, {desc = desc})
        end

        map('w',  'next word (nvim-spider)')
        map('e',  'end of word (nvim-spider)')
        map('b',  'prev word (nvim-spider)')
        map('ge', 'end of prev  word (nvim-spider)')
    end
}
