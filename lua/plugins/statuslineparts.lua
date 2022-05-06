local devicons = require('nvim-web-devicons')
local icon     = require('util').icon

local function lsp_enabled()
    local attached_client = next(vim.lsp.buf_get_clients()) ~= nil
    local normal_buffer   = vim.bo.buftype == ''
    return attached_client and normal_buffer
end

local function diagnose(severity, ico)
    if not lsp_enabled() then return end

    local count = #vim.diagnostic.get(nil, {severity = severity})
    if count > 0 then return icon(ico, count) end
end

-- Functions that serve as statusbar components
return {
    diagErrors = function() return diagnose(vim.diagnostic.severity.ERROR, 'error') end,

    diagWarnings = function() return diagnose(vim.diagnostic.severity.WARNING, 'warning') end,

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

        return #ftype == 0 and fticon or string.format('%s %s', fticon, ftype)
    end,

    lsp_status = function() return lsp_enabled() and icon('lsp') end,

    modified = function() return vim.bo.modified and icon('plus') end,

    readonly = function() return vim.bo.readonly and icon('lock') end,
}
