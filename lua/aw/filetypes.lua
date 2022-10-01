local autocmd = AW.autocmd

vim.filetype.add {
    extension = {
        pm = 'perl',
        t  = 'perl',
        tt = 'tt2html'
    }
}

-- Four-space expansion
autocmd('Filetype', {'go', 'lua', 'perl'}, {shiftwidth=4, softtabstop=4, tabstop=4})

-- Unique widths
autocmd('Filetype', 'make', {expandtab=false, tabstop=8, shiftwidth=8})
autocmd('Filetype', 'text', {textwidth=74})

-- Expand tabs for system conf files and port Makefiles
autocmd({'BufRead', 'BufNewFile'}, {'*/ports/*', '/etc/*', '/usr/local/etc/*'},
    {expandtab=false, tabstop=8, shiftwidth=8}
)

-- Git
autocmd('BufRead', 'COMMIT_EDITMSG', {spell=true})

-- Jump to position of last close
autocmd('BufReadPost', '*', function()
    -- Always start git commits at the beginning
    if vim.fn.expand('%:t') == 'COMMIT_EDITMSG' then return end

    local lastline, lastcol = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local eof = vim.api.nvim_buf_line_count(0)

    if lastline > 0 and lastline <= eof then
        vim.api.nvim_win_set_cursor(0, {lastline, lastcol})
    end
end)

-- Filetype-specific settings
vim.g.is_bash = 1  -- BSD sh isn't pure POSIX
vim.g.perl_sub_signatures = 1
vim.g.ruby_operators = 1
