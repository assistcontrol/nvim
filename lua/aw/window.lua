-- Dim inactive windows
local H = {}

H.Config = {
    dim = {
        cursor_buftypes = {'', 'help', 'quickfix'},  -- Show cursor in these. '' is for normal buffers
        highlight = {
            active   = 'Normal:CustomActiveWindow',
            inactive = 'NormalNC:CustomInactiveWindow,EndOfBuffer:CustomInactiveBlank'
        }
    },
}


-- Window autocommands
vim.api.nvim_create_autocmd('WinEnter', {
    callback = function()
        H.activate_window()
    end
})

vim.api.nvim_create_autocmd('WinLeave', {
    callback = function()
        H.inactivate_window()
    end
})


-- Dim inactive windows
H.show_cursor = function()
    local cur_buftype = vim.api.nvim_buf_get_option(0, 'buftype')

    for _, buftype in ipairs(H.Config.dim.cursor_buftypes) do
        if cur_buftype == buftype then return true end
    end
end

H.activate_window = function()
    vim.opt_local.winhighlight = H.Config.dim.highlight.active

    if H.show_cursor() then
        vim.opt_local.cursorline   = true
    end
end

H.inactivate_window = function()
    vim.opt_local.winhighlight = H.Config.dim.highlight.inactive

    if H.show_cursor() then
        vim.opt_local.cursorline   = false
    end
end
