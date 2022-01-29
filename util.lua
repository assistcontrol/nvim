local icons = {
    add      = '▷',  -- u25B7
    close    = '✘',  -- u2718
    delete   = '',  -- uF00D
    dotfiles = '⚆',  -- u2686
    error    = '⨂',  -- u2A02
    folder   = '',  -- uF74A
    go       = '',  -- uE626
    horizbar = '─',  -- u2500
    lock     = '',  -- uF023
    new      = '',  -- uF15B
    plug     = '',  -- uF1E6
    plus     = '',  -- uF44D
    recent   = 'ﮫ',  -- uFBAB
    vertbar  = '│',  -- u2502
    warning  = '',  -- u26A0
}

return {
    icon = function(ico, str)
        if str then
            return icons[ico] .. ' ' .. str
        end

        return icons[ico]
    end,

    map = function(mode, keys, cmd, opts)
        opts = vim.tbl_deep_extend('force', {noremap = true, silent = true}, opts or {})

        if opts.buffer then
            vim.api.nvim_buf_set_keymap(opts.buffer, mode, keys, cmd, opts)
        else
            vim.api.nvim_set_keymap(mode, keys, cmd, opts)
        end
    end
}
