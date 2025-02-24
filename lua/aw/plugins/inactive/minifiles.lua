if not AW.has('mini.files') then return end
if vim.g.vscode then return end

require('mini.files').setup {
    windows = {
        preview = true,
        width_focus = 30,
        width_preview = 40
    }
}

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

-- Called when file window is spawned
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local buf_id = args.data.buf_id
        map_split(buf_id, 'gs', 'belowright horizontal')
        map_split(buf_id, 'gv', 'belowright vertical')
    end
})

-- Customize the float window
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
        local winid = args.data.win_id
        vim.api.nvim_win_set_config(winid, {border = 'rounded'})
    end
})
