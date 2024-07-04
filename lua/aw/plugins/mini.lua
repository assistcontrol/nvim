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
            if not vim.g.vscode then
                -- Animation
                -- require('mini.animate').setup {}

                -- Completion
                require('mini.completion').setup {}

                -- Diff
                require('aw/plugins/spec/minidiff')

                -- String highlighting
                require('aw/plugins/spec/minihipatterns')

                -- Notifications
                require('aw/plugins/spec/mininotify')

                -- Picker
                require('aw/plugins/spec/minipick')

                -- Tab line
                require('mini.tabline').setup {}

            end

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

            -- Load extra pickers, etc.
            require('mini.extra').setup {}

            -- Fancy icons
            require('mini.icons').setup {}

            -- Bubble blocks
            require('aw/plugins/spec/minimove')

            -- Split/join vectors
            require('mini.splitjoin').setup {}

            -- Surrounders (cs, ysW, etc.)
            require('aw/plugins/spec/minisurround')

            -- Whitespace at EOL
            require('mini.trailspace').setup {}
        end)
    end
}
