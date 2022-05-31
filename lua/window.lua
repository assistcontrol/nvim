local H = {}

H.DimConfig = {
    dimmable_buftypes = {'', 'help'},
    highlight = {
        active   = 'Normal:CustomActiveWindow',
        inactive = 'NormalNC:CustomInactiveWindow,EndOfBuffer:CustomInactiveEOB'
    }
}

H.ResizeConfig = {
    ignored_buftypes = {'quickfix', 'terminal'},
    -- Only activate if at least this big
    min_size         = {height = 50, width = 12 }
}


-- Dim inactive windows
H.is_dimmable = function()
    local cur_buftype = vim.api.nvim_buf_get_option(0, 'buftype')

    for _, buftype in ipairs(H.DimConfig.dimmable_buftypes) do
        if cur_buftype == buftype then return true end
    end
end

H.activate_window = function()
    local cur_buftype = vim.api.nvim_buf_get_option(0, 'buftype')

    -- Only monkey with numbers in normal buffers
    if cur_buftype == '' then
        vim.opt_local.number       = true
        vim.opt_local.signcolumn   = 'auto'
    end

    if H.is_dimmable() then
        vim.opt_local.cursorline   = true
        vim.opt_local.winhighlight = H.DimConfig.highlight.active
    end
end

H.inactivate_window = function()
    if H.is_dimmable() then
        vim.opt_local.cursorline   = false
        vim.opt_local.number       = false
        vim.opt_local.signcolumn   = 'no'
        vim.opt_local.winhighlight = H.DimConfig.highlight.inactive
    end
end


-- Resize windows according to the golden ratio
H.resize_window = function()
    local GoldenRatio = 1.618

    local is_floating_window = (vim.api.nvim_win_get_config(0))['relative'] ~= ''
    local buftype = vim.api.nvim_buf_get_option(0, 'buftype')

    -- Only resize in large windows
    local root_width = vim.api.nvim_get_option('columns')
    local root_height = vim.api.nvim_get_option('lines')
    if root_width < H.ResizeConfig.min_size.width or root_height < H.ResizeConfig.min_size.height then return end

    -- Don't resize floating and special windows
    if is_floating_window then return end
    for _, buf in ipairs(H.ResizeConfig.ignored_buftypes) do
        if buftype == buf then return end
    end

    -- Resize horizontally
    local current_width = vim.api.nvim_win_get_width(0)
    local golden_width  = math.floor(root_width/GoldenRatio)
    if current_width < golden_width then
        vim.api.nvim_win_set_width(0, golden_width)
    end

    -- Resize vertically
    local current_height = vim.api.nvim_win_get_height(0)
    local golden_height  = math.floor(root_height/GoldenRatio)
    if current_height < golden_height then
        vim.api.nvim_win_set_height(0, golden_height)
    end
end


-- Set up autocommands
vim.api.nvim_create_autocmd('WinEnter', {
    callback = function()
        H.activate_window()
        H.resize_window()
    end
})

vim.api.nvim_create_autocmd('WinLeave', {
    callback = function()
        H.inactivate_window()
    end
})
