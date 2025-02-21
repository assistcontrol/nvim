-- Indent guides
return  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    main = 'ibl',
    opts = {
        exclude = {
            buftypes  = {'help', 'nofile'},
            filetypes = {'alpha', 'dashboard', 'help', 'packer', 'starter', 'startify'}
        }
    }
}
