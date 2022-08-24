require('focus').setup {
    excluded_filetypes = {'NvimTree', 'starter'},

    autoresize = false,
    cursorline = true,
    number     = true,
    signcolumn = false
}


-- Focus shows numbers on everything, even when they've
-- been previously disabled. Re-disable them on enter.
local bare_filetypes = {
    help     = true,
    NvimTree = true,
    starter  = true
}

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
    callback = function()
        if bare_filetypes[vim.o.filetype] then
            vim.opt_local.number = false
        end
    end
})
