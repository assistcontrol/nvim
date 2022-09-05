require('tint').setup {
    ignorefunc = function(winid)
        -- Should we ignore? Return false: tint, true: do not tint
        local buf     = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')

        -- Only tint when buftype is ''
        return not buftype == ''
    end
}
