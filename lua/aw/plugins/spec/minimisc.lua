if not AW.has('mini.misc') then return end

local misc = require('mini.misc')
misc.setup {}

-- cd to appropriate dir
misc.setup_auto_root {'.git', 'Makefile', '.root'}

-- restore cursor position
if not AW.is_root() then
    -- Fails as root for some reason
    misc.setup_restore_cursor {}
end
