local icons = {
    add      = '▷',  -- u25B7
    close    = '✘',  -- u2718
    delete   = '',  -- uF00D
    dotfiles = '⚆',  -- u2686
    folder   = '',  -- uF74A
    generic  = '',  -- uF0F6
    go       = '',  -- uE626
    lock     = '',  -- uF023
    lsp      = '',  -- uF04B
    modified = '',  -- uEA71
    new      = '',  -- uF15B
    plug     = '',  -- uF1E6
    recent   = 'ﮫ',  -- uFBAB
    reload   = '',  -- uF0E2
    search   = '',  -- uF422
    tree     = 'פּ',  -- uFB44
    vim      = '',  -- uE62B

    -- Diagnostics
    error    = '⨂',  -- u2A02
    errorSm  = '',  -- uF46E
    hint     = '',  -- uF835
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
    return str and string.format('%s %s', icons[ico], str) or icons[ico]
end
