if not AW.has('mini.pick') then return end

local window = function()
    local size = 0.55

    local height = math.floor(size * vim.o.lines)
    local width  = math.floor(size * vim.o.columns)

    return {
        border = 'solid',
        anchor = 'NW',
        height = height,
        width  = width,
        row    = math.floor(0.5 * (vim.o.lines   - height)),
        col    = math.floor(0.5 * (vim.o.columns - width)),
    }
end

require('mini.pick').setup {
    options = {
        -- content_from_bottom = true,
        use_cache = true,
    },
    window = {
        config = window
    },
}
