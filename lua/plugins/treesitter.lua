require('nvim-treesitter.configs').setup {
    ensure_installed = {'bash', 'go', 'html', 'javascript', 'json', 'lua', 'perl', 'regex', 'ruby', 'scss', 'yaml'},
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true
    },
    textobjects = {
        move = {
            enable    = true,
            set_jumps = true,  -- Add each jump to jumplist

            goto_previous_start = {
                ['[m'] = '@function.outer'
            },
            goto_next_start = {
                [']m'] = '@function.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer'
            },
        },
        select = {
            enable    = true,
            lookahead = true,  -- Scan ahead for a match

            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner'
            }
        },
    }
}
