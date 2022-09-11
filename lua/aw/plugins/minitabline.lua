if not AW.has('mini.tabline') then return end

require('mini.tabline').setup {}

AW.colorcmd.register [[
    hi! link MiniTablineCurrent         CustomBright
    hi! link MiniTablineVisible         CustomMedium
    hi! link MiniTablineHidden          CustomSoft
    hi! link MiniTablineModifiedCurrent CustomBright
    hi! link MiniTablineModifiedVisible CustomMedium
    hi! link MiniTablineModifiedHidden  CustomMediumError
    hi! link MiniTablineTabpagesection  CustomSoft
]]
