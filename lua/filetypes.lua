-- Use filetype.lua instead of filetype.vim
vim.g.do_filetype_lua    = 1
vim.g.did_load_filetypes = 0

vim.filetype.add {
    extension = {
        pm = 'perl',
        tt = 'tt2html'
    }
}

local autocmd = {
    -- Four-space expansion
    ['Filetype go,lua,perl'] = 'shiftwidth=4 softtabstop=4 tabstop=4',

    -- Unique widths
    ['Filetype make'] = 'noexpandtab tabstop=8 shiftwidth=8',
    ['Filetype text'] = 'textwidth=74',

    -- Expand tabs for system conf files and port Makefiles
    ['BufRead,BufNewFile */ports/*,/etc/*,/usr/local/etc/*'] = 'noexpandtab tabstop=8 shiftwidth=8',

    -- Spell-check git commits
    ['BufRead COMMIT_EDITMSG'] = 'spell'
}

for target, action in pairs(autocmd) do
    vim.cmd(string.format('autocmd %s setlocal %s', target, action))
end

-- Jump to position at last close
vim.cmd([[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])

-- Filetype-specific settings
vim.g.is_bash = 1  -- BSD sh isn't pure POSIX
vim.g.perl_sub_signatures = 1
vim.g.ruby_operators = 1
