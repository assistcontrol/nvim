-- Color highlighting
return {
    'nvchad/nvim-colorizer.lua',
    enabled = not AW.is_root(),
    event = 'BufReadPre',
    opts = {
        filetypes = {
            '*',
            css  = {css = true, names = true},
            html = {names = true, tailwind = true}
        },
        user_default_options = {
            RGB    = true,
            RRGGBB = true,
            names  = false
        }
    }
}
