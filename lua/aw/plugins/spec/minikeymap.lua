if not AW.has('mini.keymap') then return end
if vim.g.vscode then return end

local keymap = require('mini.keymap')
local multistep = keymap.map_multistep
local combo = keymap.map_combo

local insert = {'l'}                 -- Ins, Command-Line, Lang-Arg(?)
local normal = {'n', 'v', 'o'}       -- Norm, Vis + Sel, Op-Pend
local canESC = {'c', 'i', 'x', 's'}  -- Cmd, Ins, Vis + Sel, Op-Pend

-- Tab completion
multistep(insert, '<Tab>',   {'pmenu_next', 'jump_after_tsnode', 'jump_after_close'})
multistep(insert, '<S-Tab>', {'pmenu_prev', 'jump_before_tsnode', 'jump_before_open'})
multistep(insert, '<CR>',    {'pmenu_accept', 'nvimautopairs_cr'})
multistep(insert, '<BS>',    {'nvimautopairs_bs'})

-- In normal mode, Tab/S-Tab will do indents if the cursor is on some
-- indentation. Otherwise, it'll jump around to nearby nodes.
multistep(normal, '<Tab>',   {'increase_indent', 'jump_after_tsnode', 'jump_after_close'})
multistep(normal, '<S-Tab>', {'decrease_indent', 'jump_before_tsnode', 'jump_before_open'})

-- Mash j and k, or jj/kk in place of ESC
local mash_map = function(lhs)
    combo({'c', 'i', 'x', 's'}, lhs, '<BS><BS><Esc>')
end
mash_map('jk')
mash_map('kj')

-- Reference:
--  Mode | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
--       +------+-----+-----+-----+-----+-----+------+------+ ~
--    n  | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
--    i  |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
--    c  |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
--    v  |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
--    x  |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
--    s  |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
--    o  |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
--    t  |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
--    l  |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
