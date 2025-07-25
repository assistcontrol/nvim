-- AW.autocmd creates autocmmands
-- Pass either a function or a table of setlocal options
-- Can also be called as AW.autocmd(event, cmds)
local AUGROUP = vim.api.nvim_create_augroup('AW', {})

function AW.autocmd(event, pattern, cmds)
    -- If two args, then drop pattern
    if cmds == nil then
        cmds = pattern
        pattern = nil
    end

    local callback = type(cmds) == 'function' and cmds or function()
        for opt, val in pairs(cmds) do
            vim.opt_local[opt] = val
        end
    end

    vim.api.nvim_create_autocmd(event, {
        callback = callback,
        group    = AUGROUP,
        pattern  = pattern
    })
end

-- AW.cr_action is a helper function for <CR> mappings.
-- Copied from :h mini.completion
local keys = {
    ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
    ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
    ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}
function AW.cr_action()
    if vim.fn.pumvisible() ~= 0 then
        -- If something is selected, <CR> confirms it
        -- If nothing is selected, close the popup and send a newline
        if vim.fn.complete_info().selected ~= -1 then
            return keys['ctrl-y']
        else
            return keys['ctrl-y_cr']
        end
    else
        -- If popup is not visible, use plain '<CR>'
        -- return require('nvim-autopairs').autopairs_cr()
        return keys.cr
    end
end

-- AW.defer schedules vim cmds to be run after loading is done
function AW.defer(cmd, event)
    vim.api.nvim_create_autocmd(event or 'VimEnter', { callback = function()
        vim.cmd(cmd)
    end })
end

-- AW.filebrowser spawns a file finder, and changes to a specified dir
-- for future searches
function AW.filebrowser(dir)
    Snacks.picker.files({cwd = dir or '.'})
end

-- AW.has tests whether a certain plugin is installed
function AW.has(mod)
    local exists, _ = pcall(require, mod)
    return exists
end

-- AW.is_root returns true if this user is root
function AW.is_root()
    return os.getenv('USER') == 'root'
end

-- AW.next_pane jumps to best next pane. Window preferred over buffer.
function AW.next_pane()
    if #vim.api.nvim_tabpage_list_wins(0) > 1 then
        AW.next_window()
    else
        vim.cmd [[bnext]]
    end
end

-- AW.next_window jumps to best next window. Bypasses explorer windows.
function AW.next_window()
    local skip = {'minimap', 'neo-tree', 'NvimTree'}

    for _ = 1,4 do
        vim.cmd [[wincmd w]]
        if not vim.tbl_contains(skip, vim.bo.filetype) then break end
    end
end

-- AW.pretty_print deeply prints its argument using vim.inspect.
-- Mapped to a global function `pp`.
function AW.pretty_print(obj)
    print(vim.inspect(obj))
end
_G.pp = AW.pretty_print

-- AW.pwd returns a shortened $PWD
function AW.pwd()
    local pwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':~:.')
    return (pwd == '' or pwd == '~') and '~/' or pwd
end

-- AW.purge_whitespace trims all trailing whitespace
function AW.purge_whitespace()
    require('mini.trailspace').trim()
    require('mini.trailspace').trim_last_lines()
end
vim.api.nvim_create_user_command('WhitespaceTrim', AW.purge_whitespace, {})

-- AW.send_cmdn sends a normal-mode command in every mode I can think of
function AW.send_cmdn(cmd)
    local mode = vim.fn.mode()
    if mode:match('^[nvV\x16]$') then   -- normal, visual, linewise, blockwise
        vim.cmd('normal! ' .. cmd)
    elseif mode:match('^i$') or mode:match('^R') then   -- insert, replace
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-o>' .. cmd, true, false, true), 'n', false)
    else
        vim.notify(string.format("Cannot send '%s' in mode '%s'", cmd, mode))
    end
end

-- AW.smart_end goes to EOL
function AW.smart_end()
    AW.send_cmdn('$')
end

-- AW.smart_home goes to ^, or 0 if we're already at ^. If at 0, it'll jump
-- forward to ^.
function AW.smart_home()
    local start_of_line = vim.fn.matchstrpos(vim.fn.getline('.'), '\\S')[2] + 1

    AW.send_cmdn(vim.fn.col('.') == start_of_line and '0' or '^')
end

-- AW.toggle toggles a setting, either a string ('number') or the lua
-- object (vim.o.number). This allows setting buffer-local scope
-- easily (vim.bo.number).
function AW.toggle(setting)
    if type(setting) == 'string' then
        vim.o[setting] = not vim.o[setting]
    elseif type(setting) == 'boolean' then
        setting = not setting
    else
        vim.notify("AW.toggle: Cannot toggle type: " .. type(setting))
    end
end

-- AW.toggle_quickfix toggles the quickfix window
function AW.toggle_quickfix()
    local qf_windows = vim.tbl_filter(
        function(winid) return vim.fn.getwininfo(winid)[1].quickfix == 1 end,
        vim.api.nvim_tabpage_list_wins(0)
    )

    local cmd = #qf_windows == 0 and 'copen' or 'cclose'
    vim.cmd(cmd)
end

-- AW.update_plugins updates all the things
-- Handles plugins and treesitter parsers.
function AW.update_plugins()
    vim.cmd(':TSUpdate')
    require('lazy').sync()
end

-- Flash yanked lines
-- This doesn't belong in this file, but it belongs even less in
-- any other file.
AW.autocmd('TextYankPost', function()
    vim.highlight.on_yank {
        higroup   = 'IncSearch',
        on_visual = false,
        timeout   = 150
    }
end)
