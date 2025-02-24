if not AW.has('mini.starter') then return end
if vim.g.vscode then return end

local starter = require('mini.starter')

local H = {}

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

        H.item('Browse', 'b', 'folder',   AW.pwd(),    [[lua AW.filebrowser()]]),
        H.item('Browse', 'x', 'filetree', 'tree',      [[lua Snacks.picker.explorer({layout = {preset = 'default', preview = true}})]]),
        H.item('Browse', 'l', 'search',   'live grep', [[lua Snacks.picker.grep()]]),
        H.item('Browse', 'r', 'recent',   'recent',    [[lua Snacks.picker.recent()]]),
        H.item('Browse', 'p', 'recent',   'projects',  [[lua Snacks.picker.projects()]]),
        H.item('Browse', 'n', 'ninja',    'ninja',     [[lua AW.filebrowser('~/build/ninja')]]),
        H.item('Browse', 'd', 'dotfiles', 'dotfiles',  [[lua AW.filebrowser('~/build/dotfiles')]]),
        H.item('Browse', 'v', 'vim',      'vim',       [[lua AW.filebrowser('~/build/nvim/lua/aw')]]),
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
