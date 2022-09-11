if not AW.has('window-picker') then return end

require('window-picker').setup {
    fg_color = 'black',
    include_current_win = true,
    selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
}
