-- Window picker

local hintcolors = {
    fg = '#11111B',
    bg = '#89DCEB',
    bold = true
}

return {
    's1n7ax/nvim-window-picker',
    enabled = not vim.g.vscode,
    lazy = true,
    opts = {
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
}
