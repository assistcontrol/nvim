local icons = {
    add      = '▷',  -- u25B7
    close    = '✘',  -- u2718
    delete   = '',  -- uF00D
    dotfiles = '⚆',  -- u2686
    folder   = '',  -- uF07B
    generic  = '',  -- uF0F6
    go       = '',  -- uE626
    lock     = '',  -- uF023
    lsp      = '',  -- uF04B
    modified = '',  -- uF10C
    more     = '',  -- uF141
    new      = '',  -- uF15B
    plug     = '',  -- uF1E6
    prompt   = '',  -- f054
    recent   = '󰚭',  -- UF06AD
    record   = '󰏤',  -- UF03E4
    reload   = '',  -- uF0E2
    search   = '',  -- uF422
    tree     = '󰙅',  -- UF0645
    vim      = '',  -- uE62B

    -- Diagnostics
    error    = '⨂',  -- u2A02
    errorSm  = '',  -- uF46E
    hint     = '󰌶',  -- UF0336
    warning  = '',  -- u26A0

    -- Box-drawing
    horizlow  = '▁',  -- u2581
    horizmid  = '─',  -- u2500
    horizhigh = '▔',  -- u2594
    thickvert = '▌',  -- u258C
    vertbar   = '│',  -- u2502
}

-- AW.icon gets an icon, with optional text attached
function AW.icon(ico, str)
    local icon = icons[ico] and icons[ico] .. ' ' or ''
    local s    = str and str or ''
    return icon .. s
end
