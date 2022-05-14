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
    lsp      = '',  -- uF04B
    new      = '',  -- uF15B
    plug     = '',  -- uF1E6
    plus     = '',  -- uF44D
    recent   = 'ﮫ',  -- uFBAB
    vertbar  = '│',  -- u2502
    vim      = '',  -- uE62B
    warning  = '',  -- u26A0
}

return {
    filebrowser = function(dir)
        if dir then vim.cmd('lcd ' .. dir) end
        require('telescope.builtin').find_files()
    end,

    icon = function(ico, str)
        return str and string.format('%s %s', icons[ico], str) or icons[ico]
    end,

    map = function(mode, keys, cmd, opts)
        opts = vim.tbl_deep_extend('force', {noremap = true, silent = true}, opts or {})

        vim.keymap.set(mode, keys, cmd, opts)
    end,

    -- Schedule vim cmds to be run after loading is done
    -- In particular, this stops plugins from clobbering highlighting
    on_load = function(cmd)
        vim.api.nvim_create_autocmd('VimEnter', { callback = function()
            vim.api.nvim_exec(cmd, false)
        end })
    end
}
