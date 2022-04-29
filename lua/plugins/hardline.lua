local parts = require('plugins/statuslineparts')

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
        {class = 'error',   item = parts.diagError},
        {class = 'warning', item = parts.diagWarning},
        {class = 'warning', item = require('hardline.parts.whitespace').get_item},
        {class = 'high',    item = parts.encoding},
        {class = 'high',    item = parts.format},
        {class = 'high',    item = parts.filetype, hide = 80},
        {class = 'mode',    item = require('hardline.parts.line').get_item}
    }
}
