if not AW.has('mini.pick') then return end

local pick = require('mini.pick')

local window = function()
    local size = 0.618

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

pick.setup {
    options = {
        -- content_from_bottom = true,
        use_cache = true,
    },
    window = {
        config = window
    },
}

-- :Pick files cwd='...'
pick.registry.files = function(local_opts)
    local opts = { source = { cwd = local_opts.cwd }}
    local_opts.cwd = nil
    return pick.builtin.files(local_opts, opts)
end

-- Override ui_select
vim.ui.select = pick.ui_select
