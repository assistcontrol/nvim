-- mini.nvim package
return {
    'echasnovski/mini.nvim',

    config = function()
        -- Load this stuff right away; needed for startup.

        -- Start screen
        require('aw/plugins/spec/ministarter')

        -- Status line
        require('aw/plugins/spec/ministatusline')

        -- Cool stuff like auto-root, cursor restore, etc.
        require('aw/plugins/spec/minimisc')

        require('aw/plugins/spec/minifiles')

        -- Not needed until later
        AW.autocmd('User', 'VeryLazy', function()
            -- Animation
            -- NOTE: Try this again once 0.9 is released
            -- require('mini.animate').setup {}

            -- a/i surrounders (a", i[, etc.)
            require('aw/plugins/spec/miniai')

            -- Align all the things
            require('mini.align').setup {}

            -- Buffer deletion
            require('mini.bufremove').setup {}

            -- ] / [ movement
            require('mini.bracketed').setup {}

            -- Comments (gc[c])
            require('aw/plugins/spec/minicomment')

            -- Completion
            require('mini.completion').setup {}

            -- Load extra pickers, etc.
            require('mini.extra').setup {}

            -- String highlighting
            require('aw/plugins/spec/minihipatterns')

            -- Bubble blocks
            require('aw/plugins/spec/minimove')

            -- Picker
            require('aw/plugins/spec/minipick')

            -- Split/join vectors
            require('mini.splitjoin').setup {}

            -- Surrounders (cs, ysW, etc.)
            require('aw/plugins/spec/minisurround')

            -- Tab line
            require('mini.tabline').setup {}

            -- Whitespace at EOL
            require('mini.trailspace').setup {}
        end)
    end
}
