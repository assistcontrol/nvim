if not AW.has('mini.files') then return end

require('mini.files').setup {}

-- Create a split and open the selected file in it
local map_split = function(buf_id, lhs, direction)
    local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
    end

    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, {buffer = buf_id, desc = desc})
end

-- Pick a window and open the selected file in it
local pick_win = function()
    local winid = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
    MiniFiles.set_target_window(winid)
    MiniFiles.go_in()
end

-- Called when file window is spawned
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local buf_id = args.data.buf_id
        map_split(buf_id, 'gs', 'belowright horizontal')
        map_split(buf_id, 'gv', 'belowright vertical')
        vim.keymap.set('n', 'gw', pick_win, {buffer = buf_id, desc = 'Pick target'})
    end
})
