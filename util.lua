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
    end
}
