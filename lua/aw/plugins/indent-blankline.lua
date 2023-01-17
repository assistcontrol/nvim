-- Indent guides
return  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
        buftype_exclude  = {'help', 'nofile'},
        filetype_exclude = {'alpha', 'dashboard', 'help', 'packer', 'starter', 'startify'},
        show_current_context = true,
        use_treesitter       = true
    }
}
