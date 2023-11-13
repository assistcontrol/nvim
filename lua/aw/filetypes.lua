local autocmd = AW.autocmd

vim.filetype.add {
    extension = {
        pm = 'perl',
        t  = 'perl',
        tt = 'tt2html',
        v  = 'v',
    }
}

-- Four-space expansion
autocmd('Filetype', {'go', 'lua', 'perl', 'v'}, {shiftwidth=4, softtabstop=4, tabstop=4})

-- Unique widths
autocmd('Filetype', 'make', {expandtab=false, tabstop=8, shiftwidth=8})
autocmd('Filetype', 'text', {textwidth=74})

-- Expand tabs for system conf files and port Makefiles
autocmd({'BufRead', 'BufNewFile'}, {'*/ports/*', '/etc/*', '/usr/local/etc/*'},
    {expandtab=false, tabstop=8, shiftwidth=8}
)

-- Git
autocmd('BufRead', 'COMMIT_EDITMSG', {spell=true})

-- Filetype-specific settings
vim.g.is_bash = 1  -- BSD sh isn't pure POSIX
vim.g.perl_sub_signatures = 1
vim.g.ruby_operators = 1
