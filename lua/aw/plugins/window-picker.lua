-- Window picker

local hintcolors = {
    fg = '#11111B',
    bg = '#89DCEB',
    bold = true
}

-- XXX: WINDOW-PICKER IS CURRENTLY BROKEN
-- M.setup() is an empty stub. Until it's fixed, the config has to be a global
-- so it can be passed to pick_window().
AW.window_picker_config = {
    include_current_win = true,
    selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',

    picker_config = {
        statusline_winbar_picker = {
            selection_display = function(char) return char .. ': %f' end,
            use_winbar = 'always',
        }
    },

    highlights = {
        statusline = {
            focused   = hintcolors,
            unfocused = hintcolors,
        },
        winbar = {
            focused   = hintcolors,
            unfocused = hintcolors,
        }
    }
}

return {
    's1n7ax/nvim-window-picker',
    lazy = true,
    opts = AW.window_picker_config
}
