if not AW.has('mini.starter') then return end

local starter = require('mini.starter')

local H = {}

H.browse = function(dir)
    return string.format([[lua AW.filebrowser("%s")]], dir)
end

H.item = function(section, key, ico, title, action)
    return {
        action  = action,
        section = section,
        name    = string.format('%s  %s', key, AW.icon(ico, title))
    }
end

H.version = function()
    local version = vim.version()
    return string.format('nvim v%d.%d.%d │ %s',
        version.major, version.minor, version.patch,
        os.date('%a %Y/%m/%d %H:%M')
    )
end

local config = {
    content_hooks = {
        starter.gen_hook.adding_bullet('', true),
        starter.gen_hook.aligning('center', 'center')
    },
    evaluate_single = true,
    query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.ABCDEFGHIJKLMNOPQRSTUVWXYZ]],
    silent = true,
    footer = '',
    header = H.version(),
    items = {
        H.item('Common', 'i', 'new',   'New file',  'enew'),
        H.item('Common', 'q', 'close', 'Quit nvim', 'qall'),

        H.item('Update', 'U', 'plug',   'Update plugins',     'lua AW.update_plugins()'),
        H.item('Update', 'G', 'go',     'Update go binaries', 'GoUpdateBinaries'),
        H.item('Update', 'T', 'tree',   'Update parsers',     'TSUpdate'),

        H.item('Browse', 'b', 'folder',   AW.pwd(),    H.browse(AW.pwd())),
        H.item('Browse', 'x', 'filetree', 'tree',      'lua MiniFiles.open()'),
        H.item('Browse', 'l', 'search',   'live grep', [[Pick grep_live]]),
        H.item('Browse', 'r', 'recent',   'recent',    [[Pick oldfiles]]),
        H.item('Browse', 'n', 'ninja',    'ninja',     H.browse("~/build/ninja")),
        H.item('Browse', 'd', 'dotfiles', 'dotfiles',  H.browse("~/build/dotfiles")),
        H.item('Browse', 'v', 'vim',      'vim',       H.browse("~/build/nvim/lua/aw"))
    }
}

starter.setup(config)

AW.autocmd('User', 'MiniStarterOpened', function()
    AW.autocmd('User', 'VeryLazy', function()
        if vim.bo.filetype ~= 'starter' then return end

        local ms = math.floor(require('lazy').stats().startuptime + 0.5)

        config.footer = '⚡' .. ms .. ' ms'
        starter.setup(config)
        starter.refresh()
    end)
end)
