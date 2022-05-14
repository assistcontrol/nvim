require('mini.tabline').setup {}

require('util').on_load [[
    hi link MiniTablineCurrent         CustomBright
    hi link MiniTablineVisible         CustomMedium
    hi link MiniTablineHidden          CustomSoft
    hi link MiniTablineModifiedCurrent CustomBright
    hi link MiniTablineModifiedVisible CustomMedium
    hi link MiniTablineModifiedHidden  CustomMediumError
    hi link MiniTablineTabpagesection  CustomSoft
]]
