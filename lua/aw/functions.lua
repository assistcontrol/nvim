-- AW.autocmd creates autocmmands
-- Pass either a function or a table of setlocal options
local AUGROUP = vim.api.nvim_create_augroup('AW', {})

function AW.autocmd(event, pattern, cmds)
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

-- AW.defer schedules vim cmds to be run after loading is done
function AW.defer(cmd, event)
    vim.api.nvim_create_autocmd(event or 'VimEnter', { callback = function()
        vim.cmd(cmd)
    end })
end

-- AW.filebrowser spawns a file finder, and changes to a specified dir
-- for future searches
function AW.filebrowser(dir)
    if dir then vim.cmd('lcd ' .. dir) end
    require('telescope.builtin').find_files()
end

-- AW.has tests whether a certain plugin is installed
function AW.has(mod)
    local exists, _ = pcall(require, mod)
    return exists
end

-- AW.map adds a keymap
local map_defaults = {noremap = true, silent = true}
function AW.map(mode, keys, cmd, opts)
    opts = opts and vim.tbl_deep_extend('force', map_defaults, opts) or map_defaults

    vim.keymap.set(mode, keys, cmd, opts)
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

-- AW.update_plugins updates all the things
-- Handles plugins and treesitter parsers.
function AW.update_plugins()
    vim.cmd(':TSUpdate')
    vim.cmd(':PackerSync')
end

-- Flash yanked lines
-- This doesn't belong in this file, but it belongs even less in
-- any other file.
vim.api.nvim_create_autocmd('TextYankPost', { callback = function()
    vim.highlight.on_yank {
        higroup   = 'IncSearch',
        on_visual = false,
        timeout   = 150
    }
end })
