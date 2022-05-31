local SL = require('mini.statusline')
local P  = require('plugins/statuslineparts')

-- More statusbar components
P.location = function(args)
    if SL.is_truncated(args.trunc_width) then
        return '%l│%2v'
    end

    local percent = math.floor(vim.fn.line('.') * 100 / vim.fn.line('$'))
    local percentString = string.format('%d%%%%', percent)

    return '%l/%L│%2v/%-2{virtcol("$") - 1}│' .. percentString
end

-- This just uppercases the mode
P.mode = function(args)
    local mode, mode_hl = SL.section_mode(args or {})
    return string.upper(mode), mode_hl
end

-- This function is called for every statusline refresh
local function content_active()
    local mode, mode_hl = P.mode({trunc_width = 50 })

    return SL.combine_groups({
        {hl = mode_hl,          strings = { mode }},
        {hl = 'CustomMedium',   strings = { SL.section_git({ trunc_width = 60 }) }},
        '%<',  -- Things before this are left-justified
        {hl = 'CustomSoft',     strings = { P.filename(), P.readonly(), P.modified() }},
        '%=',  -- Things after this are right-justified
        {hl = 'CustomMedium',   strings = { P.filesize() }},
        {hl = 'CustomMedium',   strings = { P.lsp_status() }},
        {hl = 'CustomError',    strings = { P.diagErrors() }},
        {hl = 'CustomWarning',  strings = { P.diagWarnings() }},
        {hl = 'CustomMedium',   strings = { P.encoding(), P.filefmt(), P.filetype() }},
        {hl = mode_hl,          strings = { P.location({ trunc_width = 50 }) }}
    })
end

-- Instantiate the statusline
SL.setup {
    content = {
        active = content_active
    }
}


-- Set statusline colours
AW.defer [[
    hi link MiniStatuslineModeNormal  CustomBright
    hi link MiniStatuslineModeInsert  CustomModeInsert
    hi link MiniStatuslineModeVisual  CustomModeVisual
    hi link MiniStatuslineModeReplace CustomModeReplace
    hi link MiniStatuslineModeCommand CustomModeCommand
]]
