local starter = require('mini.starter')
local icon = require('util').icon

local pwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':~:.')
if pwd == '' then pwd = '~/' end

local item = function(key, ico, title)
    return string.format('%s  %s', key, icon(ico, title))
end

function DashboardBrowse(dir)
    vim.cmd('lcd ' .. dir)
    require('telescope.builtin').find_files()
end

starter.setup {
    evaluate_single = true,
    query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.UG]],
    header = table.concat({
        '', '',
        [[            NeoVim            ]],
        [[ ──────────────────────────── ]]  -- \u2500
    }, "\n"),
    footer = os.date(),
    content_hooks = {
        starter.gen_hook.adding_bullet(''),
        starter.gen_hook.aligning('center', 'top')
    },
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

        { name = item('b', 'folder', pwd),
          action = string.format([[lua DashboardBrowse("%s")]], pwd),
          section = 'Browse'
        },
        { name = item('r', 'recent', 'Recent'),
          action = 'Telescope oldfiles',
          section = 'Browse'
        },
        { name = item('m', 'folder', 'med_apps'),
          action = [[lua DashboardBrowse("~/build/med_apps")]],
          section = 'Browse'
        },
        { name = item('d', 'dotfiles', 'dotfiles'),
          action = [[lua DashboardBrowse("~/build/dotfiles")]],
          section = 'Browse'
        },
        { name = item('v', 'vim', 'vim'),
          action = [[lua DashboardBrowse("~/build/vim/lua")]],
          section = 'Browse'
        }
    }
}
