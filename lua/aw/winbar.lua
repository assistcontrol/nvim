local devicons = require('nvim-web-devicons')

local H = {
    ignore = {'Starter'},
    trees  = {'neo-tree', 'NvimTree'}
}

H.ignore = {
    'packer',
    'starter'
}

H.fileicon = function()
    return devicons.get_icon(vim.fn.expand('%')) or AW.icon('generic')
end

H.filename = function()
    return '%t'
end

H.modified = function(bufnum)
    return vim.bo[bufnum].modified and AW.icon('modified') or ""
end

H.set = function()
    local bufnum = vim.api.nvim_get_current_buf()
    local winnum = vim.api.nvim_get_current_win()

    local ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local bt = vim.api.nvim_buf_get_option(0, 'buftype')

    -- Set tree winbar to shortened $PWD
    if vim.tbl_contains(H.trees, ft) then
        vim.wo.winbar = AW.pwd()
        return
    end

    -- Ignore floats and non-files
    if vim.tbl_contains(H.ignore, ft)
        or bt == 'nofile'
        or vim.api.nvim_win_get_config(winnum).relative ~= ""
    then
        vim.wo.winbar = nil
        return
    end

    -- Build the actual winbar
    local parts = {
        H.fileicon(),
        H.filename(),
        H.modified(bufnum)
    }

    vim.wo.winbar = table.concat(parts, ' ')
end

vim.api.nvim_create_autocmd({'BufEnter', 'VimEnter', 'TextChanged', 'TextChangedI'}, {
    callback = H.set
})
