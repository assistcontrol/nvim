local icons = {
    add      = '▷',  -- u25B7
    close    = '✘',  -- u2718
    delete   = '',  -- uF00D
    dotfiles = '⚆',  -- u2686
    error    = '⨂',  -- u2A02
    errorSm  = '',  -- uF659
    folder   = '',  -- uF74A
    go       = '',  -- uE626
    hint     = '',  -- uF835
    lock     = '',  -- uF023
    lsp      = '',  -- uF04B
    new      = '',  -- uF15B
    plug     = '',  -- uF1E6
    plus     = '',  -- uF44D
    recent   = 'ﮫ',  -- uFBAB
    reload   = '',  -- uF0E2
    vim      = '',  -- uE62B
    warning  = '',  -- u26A0

    -- Box-drawing
    horizlow  = '▁',  -- u2581
    horizmid  = '─',  -- u2500
    horizhigh = '▔',  -- u2594
    thickvert = '▌',  -- u258C
    vertbar   = '│',  -- u2502
}

-- Schedule vim cmds to be run after loading is done
function AW.defer(cmd, event)
    vim.api.nvim_create_autocmd(event or 'VimEnter', { callback = function()
        vim.cmd(cmd)
    end })
end

-- Spawn a file finder, and change to a specified dir
-- for future searches
function AW.filebrowser(dir)
    if dir then vim.cmd('lcd ' .. dir) end
    require('telescope.builtin').find_files()
end

-- Test whether a certain plugin is installed
function AW.has(mod)
    local exists, _ = pcall(require, mod)
    return exists
end

-- Get an icon, with optional text attached
function AW.icon(ico, str)
    return str and string.format('%s %s', icons[ico], str) or icons[ico]
end

-- Add a keymap
function AW.map(mode, keys, cmd, opts)
    opts = vim.tbl_deep_extend('force', {noremap = true, silent = true}, opts or {})

    vim.keymap.set(mode, keys, cmd, opts)
end

-- Jump to best next pane. Window preferred over buffer.
function AW.next_pane()
    if #vim.api.nvim_tabpage_list_wins(0) > 1 then
        vim.cmd [[wincmd w]]
    else
        vim.cmd [[bnext]]
    end
end


-- Trim all trailing whitespace
function AW.purge_whitespace()
    require('mini.trailspace').trim()
    require('mini.trailspace').trim_last_lines()
end
vim.api.nvim_create_user_command('WhitespaceTrim', AW.purge_whitespace, {})

-- Update plugins
function AW.update_plugins()
    vim.cmd(':TSUpdate')
    vim.cmd(':PackerSync')
end

-- Flash yanked lines
vim.api.nvim_create_autocmd('TextYankPost', { callback = function()
    vim.highlight.on_yank {
        higroup   = 'IncSearch',
        on_visual = false,
        timeout   = 150
    }
end })
