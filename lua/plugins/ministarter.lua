local starter = require('mini.starter')
require('plugins/telescope')  -- FileBrowser()

local pwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':~:.')
if pwd == '' then pwd = '~/' end

local browse = function(dir)
    return string.format([[lua AW.filebrowser("%s")]], dir)
end

local item = function(section, key, ico, title, action)
    return {
        action  = action,
        section = section,
        name    = string.format('%s  %s', key, AW.icon(ico, title))
    }
end

starter.setup {
    content_hooks = {
        starter.gen_hook.adding_bullet(''),
        starter.gen_hook.aligning('center', 'center')
    },
    evaluate_single = true,
    query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.ABCDEFGHIJKLMNOPQRSTUVWXYZ]],
    footer = os.date(),
    header = table.concat({
        '', '',
        [[            NeoVim            ]],
        [[ ──────────────────────────── ]]  -- \u2500
    }, "\n"),
    items = {
        item('Common', 'i', 'new',   'New file',  'enew'),
        item('Common', 'q', 'close', 'Quit nvim', 'qall'),

        item('Update', 'U', 'plug',   'Update plugins',     'lua AW.update_plugins()'),
        item('Update', 'G', 'go',     'Update go binaries', 'GoUpdateBinaries'),
        item('Update', 'C', 'reload', 'Compile plugins',    'PackerCompile'),

        item('Browse', 'b', 'folder',   pwd,        browse(pwd)),
        item('Browse', 'r', 'recent',   'Recent',   'Telescope oldfiles'),
        item('Browse', 'm', 'folder',   'med_apps', browse("~/build/med_apps")),
        item('Browse', 'd', 'dotfiles', 'dotfiles', browse("~/build/dotfiles")),
        item('Browse', 'v', 'vim',      'vim',      browse("~/build/vim/lua"))
    }
}
