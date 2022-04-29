local devicons = require('nvim-web-devicons')
local icon     = require('util').icon

-- Functions that serve as statusbar components
return {
    encoding = function()
        if vim.bo.fileencoding ~= 'utf-8' then return vim.bo.fileencoding end
    end,

    filefmt  = function() return ({dos = 'CRLF', mac = 'CR'})[vim.bo.fileformat] end,

    filename = function() return vim.fn.expand('%:~:.') end,

    filesize = function()
        local size = vim.fn.getfsize(vim.fn.getreg('%'))

        if size < 0 then
            return
        elseif size < 1024 then
            return string.format('%dB', size)
        elseif size < 1048576 then
            return string.format('%.2fKB', size / 1024)
        else
            return string.format('%.2fMB', size / 1048576)
        end
    end,

    filetype = function()
        local fticon = devicons.get_icon(vim.fn.expand('%'))
        local ftype  = vim.bo.filetype

        if #ftype == 0 then return fticon end
        return fticon .. ' ' .. ftype
    end,

    modified = function() if vim.bo.modified then return icon('plus') end end,

    readonly = function() if vim.bo.readonly then return icon('lock') end end,
}
