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

starter.setup {
    content_hooks = {
        starter.gen_hook.adding_bullet('', true),
        starter.gen_hook.aligning('center', 'center')
    },
    evaluate_single = true,
    query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.ABCDEFGHIJKLMNOPQRSTUVWXYZ]],
    footer = os.date(),
    header = table.concat({
        '              Neovim',
        '───────────────────────────────────'
    }, "\n"),
    items = {
        H.item('Common', 'i', 'new',   'New file',  'enew'),
        H.item('Common', 'q', 'close', 'Quit nvim', 'qall'),

        H.item('Update', 'U', 'plug',   'Update plugins',     'lua AW.update_plugins()'),
        H.item('Update', 'G', 'go',     'Update go binaries', 'GoUpdateBinaries'),
        H.item('Update', 'C', 'reload', 'Compile plugins',    'PackerCompile'),

        H.item('Browse', 'b', 'folder',   AW.pwd(),    H.browse(AW.pwd())),
        H.item('Browse', 'x', 'tree',     'tree',      'Neotree'),
        H.item('Browse', 'r', 'recent',   'Recent',    'Telescope oldfiles'),
        H.item('Browse', 'l', 'search',   'Live grep', 'Telescope live_grep'),
        H.item('Browse', 'm', 'folder',   'med_apps',  H.browse("~/build/med_apps")),
        H.item('Browse', 'd', 'dotfiles', 'dotfiles',  H.browse("~/build/dotfiles")),
        H.item('Browse', 'v', 'vim',      'vim',       H.browse("~/build/vim/lua/aw"))
    }
}
