return {
    'saghen/blink.lib',
    event = {'BufReadPre', 'BufNewFile'},
    config = function()
        -- blink.lib is not designed to call setup()
        -- setup() currently just raises an error
    end
}
