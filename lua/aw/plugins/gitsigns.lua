-- Git status in gutter
return {
    'lewis6991/gitsigns.nvim',
    dependencies = AW.deps.plenary,
    enabled = not AW.is_root(),
    event = 'BufReadPre',
    opts = {
        signs = {
            add          = {text = AW.icon('thickvert')},
            change       = {text = AW.icon('vertbar')},
            changedelete = {text = AW.icon('horizlow')},
            delete       = {text = AW.icon('horizlow')},
            topdelete    = {text = AW.icon('horizhigh')},
            untracked    = {text = AW.icon('vertbar')}
        },
        watch_gitdir = {interval = 300, follow_files = true},
        on_attach = AW.maps.gitsigns
    }
}
