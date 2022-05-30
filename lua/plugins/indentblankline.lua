require('indent_blankline').setup {
    buftype_exclude  = {'help', 'nofile'},
    filetype_exclude = {'alpha', 'dashboard', 'help', 'packer', 'starter', 'startify'},
    show_current_context       = true,
    show_current_context_start = true,
    show_current_context_start_on_current_line = true,
    use_treesitter             = true
}