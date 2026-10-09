if vim.g.vscode then return end

local has_miniicons, miniicons = pcall(require, 'mini.icons')

--
-- COLORCOLUMN
--
-- Two columns: One fixed, the other at textwidth
local C = {
    fixed = 80,
    fixed_color = '#45475a', -- catppuccin mocha surface1
    tw_color    = '#6c7086', -- overlay0

    ns = vim.api.nvim_create_namespace("column-rulers"),
}

vim.api.nvim_set_hl(0, 'RulerFixed', {fg = C.fixed_color})
vim.api.nvim_set_hl(0, 'RulerTextWidth', {fg = C.tw_color})

vim.api.nvim_set_decoration_provider(C.ns, {
    on_range = function(_, win, buf, first, _, last, _)
        -- Only draw on editable buffers
        if vim.bo[buf].buftype ~= '' or not vim.bo[buf].modifiable then
            return
        end
        -- Only draw on visible buffers
        if vim.api.nvim_win_get_buf(win) ~= buf then
            return
        end

        local tw = vim.bo[buf].textwidth

        for row = first, last - 1 do
            local width = vim.fn.strdisplaywidth(
                vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1]
            )
            -- Fixed column
            if width < C.fixed then
                vim.api.nvim_buf_set_extmark(buf, C.ns, row, 0, {
                    virt_text = { { '│', 'RulerFixed' } },
                    virt_text_win_col = C.fixed - 1,
                    ephemeral = true,
                })
            end

            -- textwidth, unless it overlaps fixed or is unset
            if tw > 0 and tw ~= C.fixed and width < tw then
                vim.api.nvim_buf_set_extmark(buf, C.ns, row, 0, {
                    virt_text = { {'│', 'RulerTextWidth'} },
                    virt_text_win_col = tw - 1,
                    ephemeral = true,
                })
            end
        end
    end
})


--
-- WINBAR
--
local H = {
    -- Skip these buffers
    ignore = {'packer', 'Starter'},
    -- File trees get a different title
    trees  = {'neo-tree', 'NvimTree'},
}

H.fileicon = function()
    return has_miniicons and miniicons.get('file', vim.fn.expand('%'))
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

AW.autocmd({'BufWinEnter', 'BufWritePost', 'VimEnter', 'TextChanged', 'TextChangedI'}, H.set)
