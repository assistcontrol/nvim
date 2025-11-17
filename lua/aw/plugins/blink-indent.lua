-- Indent guides

local rainbow = {
    'BlinkIndentCyan',
    'BlinkIndentViolet',
    'BlinkIndentYellow',
    'BlinkIndentBlue',
    'BlinkIndentGreen',
    'BlinkIndentOrange',
    'BlinkIndentRed',
}

return {
    'saghen/blink.indent',
    opts = {
        static = {
            char = '┃',
            whitespace_char = ' ',  -- Just a space
        },

        scope = {
            char = '┃',
            highlights = rainbow,
        },
    },
}
