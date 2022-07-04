require('indent_blankline').setup {
    buftype_exclude  = {'help', 'nofile'},
    filetype_exclude = {'alpha', 'dashboard', 'help', 'packer', 'starter', 'startify'},
    show_current_context       = true,
    use_treesitter             = true
}
