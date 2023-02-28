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

local config = {
    content_hooks = {
        starter.gen_hook.adding_bullet('', true),
        starter.gen_hook.aligning('center', 'center')
    },
    evaluate_single = true,
    query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.ABCDEFGHIJKLMNOPQRSTUVWXYZ]],
    footer = '',
    header = os.date(),
    items = {
        H.item('Common', 'i', 'new',   'New file',  'enew'),
        H.item('Common', 'q', 'close', 'Quit nvim', 'qall'),

        H.item('Update', 'U', 'plug',   'Update plugins',     'lua AW.update_plugins()'),
        H.item('Update', 'G', 'go',     'Update go binaries', 'GoUpdateBinaries'),

        H.item('Browse', 'b', 'folder',   AW.pwd(),    H.browse(AW.pwd())),
        H.item('Browse', 'x', 'tree',     'tree',      'NvimTreeFocus'),
        H.item('Browse', 'r', 'recent',   'Recent',    'Telescope oldfiles'),
        H.item('Browse', 'l', 'search',   'Live grep', 'Telescope live_grep'),
        H.item('Browse', 'n', 'folder',   'ninja',     H.browse("~/build/ninja")),
        H.item('Browse', 'd', 'dotfiles', 'dotfiles',  H.browse("~/build/dotfiles")),
        H.item('Browse', 'v', 'vim',      'vim',       H.browse("~/build/nvim/lua/aw"))
    }
}

starter.setup(config)

AW.autocmd('User', 'MiniStarterOpened', function()
    AW.autocmd('User', 'VeryLazy', function()
        local ms = math.floor(require('lazy').stats().startuptime + 0.5)

        config.footer = '⚡' .. ms .. ' ms'
        starter.setup(config)
        starter.refresh()
    end)
end)
