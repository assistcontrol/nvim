local SL = require('mini.statusline')
local P = require('plugins/statuslineparts')

-- Local functions that serve as statusbar components
local M = {
    location = function(args)
        if SL.is_truncated(args.trunc_width) then
            return '%l│%2v'
        end

        local percent = math.floor(vim.fn.line('.') * 100 / vim.fn.line('$'))
        local percentString = string.format('%d%%%%', percent)

        return '%l/%L│%2v/%-2{virtcol("$") - 1}│' .. percentString
    end,

    mode = function(args)
        local mode, mode_hl = SL.section_mode(args)
        return string.upper(mode), mode_hl
    end,
}

-- This function is called for every statusline refresh
local function content_active()
    local git = SL.section_git({ trunc_width = 60 })
    local location = M.location({ trunc_width = 50 })
    local mode, mode_hl = M.mode({trunc_width = 120 })

    return SL.combine_groups({
        {hl = mode_hl, strings = { mode }},
        {hl = 'CustomMedium',  strings = { git }},
        '%<',  -- Things before this are left-justified
        {hl = 'CustomSoft', strings = { P.filename(), P.readonly(), P.modified() }},
        '%=',  -- Things after this are right-justified
        {hl = 'CustomMedium', strings = { P.filesize() }},
        {hl = 'CustomMedium', strings = { P.lsp_status() }},
        {hl = 'CustomError',    strings = { P.diagErrors() }},
        {hl = 'CustomWarning',  strings = { P.diagWarnings() }},
        {hl = 'CustomMedium', strings = { P.encoding(), P.filefmt(), P.filetype() }},
        {hl = mode_hl, strings = { location }}
    })
end

-- Instantiate the statusline
SL.setup {
    content = {
        active = content_active
    }
}


-- Set statusline colours
require('util').on_load [[
    hi link MiniStatuslineModeNormal  CustomBright
    hi link MiniStatuslineModeInsert  CustomModeInsert
    hi link MiniStatuslineModeVisual  CustomModeVisual
    hi link MiniStatuslineModeReplace CustomModeReplace
    hi link MiniStatuslineModeCommand CustomModeCommand
]]
