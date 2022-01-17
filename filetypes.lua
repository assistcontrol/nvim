local function autocmd(ftype, command)
    vim.cmd(string.format('autocmd Filetype %s setlocal %s', ftype, command))
end

-- Add new filetype detections
vim.cmd('autocmd BufRead,BufNewFile /conf/nginx/* set filetype = nginx')
vim.cmd('autocmd BufRead,BufNewFile *.tt set filetype = tt2html')

-- Four-space expansion
fourSpace = {'go', 'lua', 'perl'}
for _, ft in ipairs(fourSpace) do
    autocmd(ft, 'expandtab shiftwidth=4 softtabstop=4 tabstop=4')
end

-- Unique shiftwidths/other settings
autocmd('make', 'noexpandtab tabstop=8 shiftwidth=8')
autocmd('svn',  'spell')
autocmd('text', 'textwidth=74')

-- Expand tabs for system conf files and port Makefiles
for _, path in ipairs({'*/ports/*', '/etc/*', '/usr/local/etc/*'}) do
    vim.cmd('autocmd BufRead,BufNewFile ' .. path .. ' setlocal tabstop=8 shiftwidth=8')
end

-- Jump to position at last clone
vim.cmd([[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])

-- Spell-check git commits
vim.cmd('autocmd BufRead COMMIT_EDITMSG setlocal spell')

vim.o.suffixes = '.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc'

-- Filetype-specific settings
vim.g.is_bash = 1  -- BSD sh isn't pure POSIX
vim.g.perl_sub_signatures = 1
vim.g.ruby_operators = 1
