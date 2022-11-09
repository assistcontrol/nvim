AW.ui = {
    border = 'solid',
    borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    winblend = vim.fn.has('gui_running') > 0 and 8 or 0
}

-- AW.colorcmd stores highlight commands for deferred execution
AW.colorcmd = {
    commands = '',
    register = function(cmds)
        AW.colorcmd.commands = string.format('%s\n%s', AW.colorcmd.commands, cmds)
    end,
    load = function() vim.cmd(AW.colorcmd.commands) end
}
-- Load colors once at startup
AW.defer('lua AW.colorcmd.load()')
-- :ReloadColors will forcibly reload the color scheme
vim.api.nvim_create_user_command('ReloadColors', 'lua AW.colorcmd.load()', {})
