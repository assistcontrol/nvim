local icon = require('util').icon

local function encoding()
    if vim.bo.fileencoding ~= 'utf-8' then return vim.bo.fileencoding end
end

local function filename()
    local name = vim.fn.expand('%:~:.')
    if vim.bo.readonly then name = string.format('%s %s',   name, icon('lock')) end
    if vim.bo.modified then name = string.format('%s [%s]', name, icon('plus')) end

    return name
end

local function filetype()
    local fticon = require('nvim-web-devicons').get_icon(vim.fn.expand('%'))
    local ftype = vim.bo.filetype

    if #ftype == 0 then return fticon end
    return fticon .. ' ' .. ftype
end

local function format()
    return ({dos = 'CRLF', mac = 'CR'})[vim.bo.fileformat]
end

local function lspError()
    local e = #vim.diagnostic.get(nil, {severity = vim.diagnostic.severity.ERROR})
    if e < 1 then return '' end
    return icon('error', e)
end

local function lspWarning()
    local w = #vim.diagnostic.get(nil, {severity = vim.diagnostic.severity.WARNING})
    if w < 1 then return '' end
    return icon('warning', w)
end

require('hardline').setup {
    sections = {
        {class = 'mode',    item = require('hardline.parts.mode').get_item},
        {class = 'high',    item = require('hardline.parts.git').get_item, hide = 100},
        {class = 'med',     item = filename},
        '%<',
        {class = 'med',     item = '%='},
        {class = 'low',     item = require('hardline.parts.wordcount').get_item, hide = 100},
        {class = 'error',   item = lspError},
        {class = 'warning', item = lspWarning},
        {class = 'warning', item = require('hardline.parts.whitespace').get_item},
        {class = 'high',    item = encoding},
        {class = 'high',    item = format},
        {class = 'high',    item = filetype, hide = 80},
        {class = 'mode',    item = require('hardline.parts.line').get_item}
    }
}
