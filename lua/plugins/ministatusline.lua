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
    local diagnostics = SL.section_diagnostics({ trunc_width = 60 })
    local git = SL.section_git({ trunc_width = 60 })
    local location = M.location({ trunc_width = 50 })
    local mode, mode_hl = M.mode({trunc_width = 120 })

    return SL.combine_groups({
        {hl = mode_hl, strings = { mode }},
        {hl = 'MiniStatuslineDevinfo',  strings = { git }},
        '%<',  -- Things before this are left-justified
        {hl = 'MiniStatuslineFilename', strings = { P.filename(), P.readonly(), P.modified() }},
        '%=',  -- Things after this are right-justified
        {hl = 'MiniStatuslineFilename', strings = { P.filesize() }},
        {hl = 'MiniStatuslineDevinfo',  strings = { diagnostics }},
        {hl = 'MiniStatuslineFileinfo', strings = { P.encoding(), P.filefmt(), P.filetype() }},
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
vim.api.nvim_exec([[
  hi MiniStatuslineModeNormal  ctermfg=235 ctermbg=114 guifg=#282C34 guibg=#98C379
  hi MiniStatuslineModeInsert  ctermfg=235 ctermbg=39  guifg=#282C34 guibg=#61AFEF
  hi MiniStatuslineModeVisual  ctermfg=235 ctermbg=170 guifg=#282C34 guibg=#C678DD
  hi MiniStatuslineModeReplace ctermfg=235 ctermbg=38  guifg=#282C34 guibg=#56B6C2
  hi MiniStatuslineModeCommand ctermfg=235 ctermbg=204 guifg=#282C34 guibg=#E06C75
  hi MiniStatuslineDevinfo     ctermfg=145 ctermbg=237 guifg=#ABB2BF guibg=#3E4452
  hi MiniStatuslineFilename    ctermfg=180 ctermbg=236 guifg=#E5C07B guibg=#2C323C
  hi link MiniStatuslineFileinfo MiniStatuslineDevinfo
]], false)

-- COLOURS FROM HARDLINE:
-- Hardline_med_active xxx ctermfg=180 ctermbg=236 guifg=#E5C07B guibg=#2C323C
-- Hardline_med_inactive xxx ctermfg=59 ctermbg=236 guifg=#5C6370 guibg=#2C323C
-- Hardline_mode_replace xxx ctermfg=235 ctermbg=38 guifg=#282C34 guibg=#56B6C2
-- Hardline_mode_insert xxx ctermfg=235 ctermbg=39 guifg=#282C34 guibg=#61AFEF
-- Hardline_mode_command xxx ctermfg=235 ctermbg=204 guifg=#282C34 guibg=#E06C75
-- Hardline_mode_inactive xxx ctermfg=59 ctermbg=236 guifg=#5C6370 guibg=#2C323C
-- Hardline_mode_visual xxx ctermfg=235 ctermbg=170 guifg=#282C34 guibg=#C678DD
-- Hardline_mode_normal xxx ctermfg=235 ctermbg=114 guifg=#282C34 guibg=#98C379
-- Hardline_low_active xxx ctermfg=145 ctermbg=236 guifg=#ABB2BF guibg=#2C323C
-- Hardline_low_inactive xxx ctermfg=59 ctermbg=236 guifg=#5C6370 guibg=#2C323C
-- Hardline_warning_active xxx ctermfg=235 ctermbg=180 guifg=#282C34 guibg=#E5C07B
-- Hardline_warning_inactive xxx ctermfg=59 ctermbg=236 guifg=#5C6370 guibg=#2C323C
-- Hardline_error_active xxx ctermfg=235 ctermbg=204 guifg=#282C34 guibg=#E06C75
-- Hardline_error_inactive xxx ctermfg=59 ctermbg=236 guifg=#5C6370 guibg=#2C323C
-- Hardline_high_active xxx ctermfg=145 ctermbg=237 guifg=#ABB2BF guibg=#3E4452
-- Hardline_high_inactive xxx ctermfg=59 ctermbg=236 guifg=#5C6370 guibg=#2C323C
-- Hardline_bufferline_current xxx ctermfg=235 ctermbg=114 guifg=#282C34 guibg=#98C379
-- Hardline_bufferline_separator xxx ctermfg=59 ctermbg=236 guifg=#5C6370 guibg=#2C323C
-- Hardline_bufferline_current_modified xxx ctermfg=235 ctermbg=39 guifg=#282C34 guibg=#61AFEF
-- Hardline_bufferline_background_modified xxx ctermfg=39 ctermbg=235 guifg=#61AFEF guibg=#282C34
-- Hardline_bufferline_background xxx ctermfg=114 ctermbg=235 guifg=#98C379 guibg=#282C34

-- DEFAULT MINI.STATUSLINE LINKS:
-- MiniStatuslineModeNormal xxx links to Cursor
-- MiniStatuslineModeInsert xxx links to DiffChange
-- MiniStatuslineModeVisual xxx links to DiffAdd
-- MiniStatuslineModeReplace xxx links to DiffDelete
-- MiniStatuslineModeCommand xxx links to DiffText
-- MiniStatuslineModeOther xxx links to IncSearch
-- MiniStatuslineDevinfo xxx links to StatusLine
-- MiniStatuslineFilename xxx links to StatusLineNC
-- MiniStatuslineFileinfo xxx links to StatusLine
-- MiniStatuslineInactive xxx links to StatusLineNC
