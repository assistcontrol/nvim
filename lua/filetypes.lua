-- Add new filetype detections
vim.cmd('autocmd BufRead,BufNewFile /conf/nginx/* setlocal filetype = nginx')
vim.cmd('autocmd BufRead,BufNewFile *.tt setlocal filetype = tt2html')

-- Four-space expansion
vim.cmd('autocmd Filetype go,lua,perl setlocal shiftwidth=4 softtabstop=4 tabstop=4')

-- Unique shiftwidths/other settings
vim.cmd('autocmd Filetype make setlocal noexpandtab tabstop=8 shiftwidth=8')
vim.cmd('autocmd Filetype text setlocal textwidth=74')

-- Expand tabs for system conf files and port Makefiles
vim.cmd([[autocmd BufRead,BufNewFile */ports/*,/etc/*,/usr/local/etc/* setlocal noexpandtab tabstop=8 shiftwidth=8]])

-- Jump to position at last clone
vim.cmd([[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])

-- Spell-check git commits
vim.cmd('autocmd BufRead COMMIT_EDITMSG setlocal spell')

-- Filetype-specific settings
vim.g.is_bash = 1  -- BSD sh isn't pure POSIX
vim.g.perl_sub_signatures = 1
vim.g.ruby_operators = 1
