-- Use filetype.lua instead of filetype.vim
vim.g.do_filetype_lua    = 1
vim.g.did_load_filetypes = 0

vim.filetype.add {
    extension = {
        pm = 'perl',
        t  = 'perl',
        tt = 'tt2html'
    }
}


-- Four-space expansion
vim.cmd [[autocmd Filetype go,lua,perl setlocal shiftwidth=4 softtabstop=4 tabstop=4]]

-- Unique widths
vim.cmd [[autocmd Filetype make setlocal noexpandtab tabstop=8 shiftwidth=8]]
vim.cmd [[autocmd Filetype text setlocal textwidth=74]]

-- Expand tabs for system conf files and port Makefiles
vim.cmd [[autocmd BufRead,BufNewFile */ports/*,/etc/*,/usr/local/etc/* setlocal noexpandtab tabstop=8 shiftwidth=8]]

-- Spell-check git commits
vim.cmd [[autocmd BufRead COMMIT_EDITMSG setlocal spell]]

-- Jump to position at last close
vim.cmd([[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])

-- Filetype-specific settings
vim.g.is_bash = 1  -- BSD sh isn't pure POSIX
vim.g.perl_sub_signatures = 1
vim.g.ruby_operators = 1
