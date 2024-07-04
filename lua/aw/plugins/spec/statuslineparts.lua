local miniicons = require('mini.icons')

local M = {}  -- Statusbar functions
local H = {}  -- Helper functions

H.lsp_enabled = function()
    local attached_client = next(vim.lsp.buf_get_clients()) ~= nil
    local normal_buffer   = vim.bo.buftype == ''
    return attached_client and normal_buffer
end

H.diagnose = function(severity, ico)
    if not H.lsp_enabled() then return end

    local count = #vim.diagnostic.get(nil, {severity = severity})
    if count > 0 then return AW.icon(ico, count) end
end

-- Functions that serve as statusbar components
M.diagErrors = function()
    return H.diagnose(vim.diagnostic.severity.ERROR, 'error')
end

M.diagWarnings = function()
    return H.diagnose(vim.diagnostic.severity.WARNING, 'warning')
end

M.encoding = function()
    if vim.bo.fileencoding ~= 'utf-8' then return vim.bo.fileencoding end
end

M.is_utility_window = function()
    local skipFiletypes = {'neo-tree', 'NvimTree'}
    return vim.tbl_contains(skipFiletypes, vim.bo.filetype)
end

M.filefmt  = function()
    -- Return nothing for proper unix formatting
    return ({dos = 'CRLF', mac = 'CR'})[vim.bo.fileformat]
end

M.fileicon = function()
    return miniicons.get('file', vim.fn.expand('%'))
end

M.filename = function()
    if M.is_utility_window() then
        local shortname = M.filename_simplify()
        if shortname then return shortname end
    end
    return vim.fn.expand('%:~:.')
end

M.filename_simplify = function()
    local filename = vim.fn.expand('%f')
    if string.find(filename, 'neo.tree', 1) then return 'Neo-Tree' end
    if string.find(filename, 'NvimTree', 1) then return 'NvimTree' end
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
    if M.is_utility_window() then return end

    local fticon = M.fileicon()
    local ftype  = vim.bo.filetype

    return #ftype == 0 and fticon or string.format('%s %s', fticon, ftype)
end

M.lsp_status = function()
    return H.lsp_enabled() and AW.icon('lsp')
end

M.modified = function()
    return vim.bo.modified and AW.icon('modified')
end

M.recording = function()
    return vim.fn.reg_recording() ~= '' and AW.icon('record')
end

M.readonly = function()
    return vim.bo.readonly and AW.icon('lock')
end

M.search_count = function()
    if vim.v.hlsearch == 0 then return end

    local ok, match = pcall(vim.fn.searchcount, {recompute = true})
    if not ok or match == nil or match.toal == 0 then return '' end

    if match.incomplete == 1 then return '' end

    local many  = AW.icon('more')
    local cur   = match.current > match.maxcount and many or match.current
    local total = match.total   > match.maxcount and many or match.total
    return ('%s/%s'):format(cur, total)
end

return M
