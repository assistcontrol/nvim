local devicons = require('nvim-web-devicons')

local function lsp_enabled()
    local attached_client = next(vim.lsp.buf_get_clients()) ~= nil
    local normal_buffer   = vim.bo.buftype == ''
    return attached_client and normal_buffer
end

local function diagnose(severity, ico)
    if not lsp_enabled() then return end

    local count = #vim.diagnostic.get(nil, {severity = severity})
    if count > 0 then return AW.icon(ico, count) end
end

-- Functions that serve as statusbar components
local M = {}
M.diagErrors = function()
    return diagnose(vim.diagnostic.severity.ERROR, 'error')
end

M.diagWarnings = function()
    return diagnose(vim.diagnostic.severity.WARNING, 'warning')
end

M.encoding = function()
    if vim.bo.fileencoding ~= 'utf-8' then return vim.bo.fileencoding end
end

M.filefmt  = function()
    -- Return nothing for proper unix formatting
    return ({dos = 'CRLF', mac = 'CR'})[vim.bo.fileformat]
end

M.filename = function()
    return vim.fn.expand('%:~:.')
end

M.filesize = function()
    local size = vim.fn.getfsize(vim.fn.getreg('%'))

    if size < 0 then
        return
    elseif size < 1024 then
        return string.format('%dB', size)
    elseif size < 10 * 1024 then
        return string.format('%.2fKB', size / 1024)
    elseif size < 100 * 1024 then
        return string.format('%.1fKB', size / 1024)
    elseif size < 1024 * 1024 then
        return string.format('%iKB', size / 1024)
    else
        return string.format('%.2fMB', size / (1024 * 1024))
    end
end

M.filetype = function()
    local fticon = devicons.get_icon(vim.fn.expand('%'))
    local ftype  = vim.bo.filetype

    return #ftype == 0 and fticon or string.format('%s %s', fticon, ftype)
end

M.lsp_status = function()
    return lsp_enabled() and AW.icon('lsp')
end

M.modified = function()
    return vim.bo.modified and AW.icon('plus')
end

M.readonly = function()
    return vim.bo.readonly and AW.icon('lock')
end

return M
