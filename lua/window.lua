-- Resize windows according to the golden ratio
local function resize_window()
    local IgnoredBuftypes = {'quickfix', 'terminal'}
    local Min = {height = 50, width = 120}  -- Only activate if at least this big
    local GoldenRatio = 1.618

    local is_floating_window = (vim.api.nvim_win_get_config(0))['relative'] ~= ''
    local buftype = vim.api.nvim_buf_get_option(0, 'buftype')

    -- Only resize in large windows
    local root_width = vim.api.nvim_get_option('columns')
    local root_height = vim.api.nvim_get_option('lines')
    if root_width < Min['width'] or root_height < Min['height'] then return end

    -- Don't resize floating and special windows
    if is_floating_window then return end
    for _, buf in ipairs(IgnoredBuftypes) do
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

vim.api.nvim_create_autocmd('WinEnter', {
    callback = resize_window
})
