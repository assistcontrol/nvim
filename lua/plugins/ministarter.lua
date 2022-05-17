local starter = require('mini.starter')
local icon    = require('util').icon
require('plugins/telescope')  -- FileBrowser()

local pwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':~:.')
if pwd == '' then pwd = '~/' end

local item = function(key, ico, title)
    return string.format('%s  %s', key, icon(ico, title))
end

starter.setup {
    content_hooks = {
        starter.gen_hook.adding_bullet(''),
        starter.gen_hook.aligning('center', 'top')
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
        { name = item('i', 'new', 'New file'),
          action = 'enew',
          section = 'Common'
        },
        { name = item('q', 'close', 'Quit nvim'),
          action = 'qall',
          section = 'Common'
        },

        { name = item('U', 'plug', 'Update plugins'),
          action = 'PackerSync',
          section = 'Update'
        },
        { name = item('G', 'go', 'Update go binaries'),
          action = 'GoUpdateBinaries',
          section = 'Update'
        },
        { name = item('C', 'reload', 'Compile plugins'),
          action = 'PackerCompile',
          section = 'Update'
        },

        { name = item('b', 'folder', pwd),
          action = string.format([[lua require('util').filebrowser("%s")]], pwd),
          section = 'Browse'
        },
        { name = item('r', 'recent', 'Recent'),
          action = 'Telescope oldfiles',
          section = 'Browse'
        },
        { name = item('m', 'folder', 'med_apps'),
          action = [[lua require('util').filebrowser("~/build/med_apps")]],
          section = 'Browse'
        },
        { name = item('d', 'dotfiles', 'dotfiles'),
          action = [[lua require('util').filebrowser("~/build/dotfiles")]],
          section = 'Browse'
        },
        { name = item('v', 'vim', 'vim'),
          action = [[lua require('util').filebrowser("~/build/vim/lua")]],
          section = 'Browse'
        }
    }
}
