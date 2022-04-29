local parts = require('plugins/statuslineparts')
local icon = require('util').icon

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
        {class = 'med',     item = parts.filename},
        {class = 'med',     item = parts.readonly},
        {class = 'med',     item = parts.modified},
        '%<',
        {class = 'med',     item = '%='},
        {class = 'low',     item = require('hardline.parts.wordcount').get_item, hide = 100},
        {class = 'error',   item = lspError},
        {class = 'warning', item = lspWarning},
        {class = 'warning', item = require('hardline.parts.whitespace').get_item},
        {class = 'high',    item = parts.encoding},
        {class = 'high',    item = parts.format},
        {class = 'high',    item = parts.filetype, hide = 80},
        {class = 'mode',    item = require('hardline.parts.line').get_item}
    }
}
