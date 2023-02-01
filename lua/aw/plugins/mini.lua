-- mini.nvim package
return {
    'echasnovski/mini.nvim',

    config = function()
        -- a/i surrounders (a", i[, etc.)
        require('aw/plugins/spec/miniai')

        -- animation
        -- require('mini.animate').setup {}

        -- Buffer deletion
        require('mini.bufremove').setup {}

        -- Completion
        require('mini.completion').setup {}

        -- Comments (gc[c])
        require('mini.comment').setup {}

        -- Bubble blocks
        require('aw/plugins/spec/minimove')

        -- Start screen
        require('aw/plugins/spec/ministarter')

        -- Status line
        require('aw/plugins/spec/ministatusline')

        -- Surrounders (cs, ysW, etc.)
        require('aw/plugins/spec/minisurround')

        -- Tab line
        require('aw/plugins/spec/minitabline')

        -- Whitespace at EOL
        require('mini.trailspace').setup {}

        -- ch to appropriate dir
        require('mini.misc').setup {}
        MiniMisc.setup_auto_root {'.git', 'Makefile', '.root'}
        MiniMisc.setup_restore_cursor {}
    end
}
