-- Window picker
return {
    's1n7ax/nvim-window-picker',
    lazy = true,
    opts = {
        fg_color = 'black',
        include_current_win = true,
        selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        selection_display = function(char) return char .. ': %f' end,
        use_winbar = 'always'
    }

}
