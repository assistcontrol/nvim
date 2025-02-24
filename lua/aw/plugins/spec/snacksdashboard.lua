if vim.g.vscode then return {enabled = false} end

local H = {
    date = function()
        return os.date('%a %Y/%m/%d %H:%M')
    end,

    item = function(key, desc, icon, action)
        return { key = key, desc = desc, icon = AW.icon(icon), action = action, indent = 2 }
    end,

    version = function()
        local version = vim.version()
        return string.format('nvim v%d.%d.%d', version.major, version.minor, version.patch)
    end,
}

return {
    preset = {
        header = H.version(),
    },

    sections = {
        { title = H.version(), padding = {2, 0}, align = 'right' },

        { title = 'Common' },
        H.item('i', 'New file', 'new', [[:enew]]),
        H.item('q', 'Quit nvim', 'quit', [[:qall]]),

        { title = '' },
        { title = 'Update' },
        H.item('U', 'Update plugins',     'plug', [[:lua AW.update_plugins()]]),
        H.item('G', 'Update go binaries', 'go',   [[:GoUpdateBinaries]]),
        H.item('T', 'Update parsers',     'tree', [[:TSUpdate]]),

        { title = '' },
        { title = 'Browse' },
        H.item('b', AW.pwd(),    'folder',   [[:lua AW.filebrowser()]]),
        H.item('x', 'tree',      'filetree', [[:lua Snacks.picker.explorer({layout = {preset = 'default', preview = true}})]]),
        H.item('g', 'live grep', 'search',   [[:lua Snacks.picker.grep()]]),
        H.item('r', 'recent',    'recent',   [[:lua Snacks.picker.recent()]]),
        H.item('n', 'ninja',     'ninja',    [[:lua AW.filebrowser('~/build/ninja')]]),
        H.item('d', 'dotfiles',  'dotfiles', [[:lua AW.filebrowser('~/build/dotfiles')]]),
        H.item('v', 'vim',       'vim',      [[:lua AW.filebrowser('~/build/nvim/lua/aw')]]),

        { pane = 2, title = H.date(), padding = {2, 0}, align = 'left' },
        { pane = 2, section = 'projects', icon = AW.icon('recent'), title = 'Projects', indent = 2 },

        { pane = 2, title = '', padding = 0 },
        { pane = 2, section = 'terminal', icon = AW.icon('git'), title = 'Git Status', indent = 2, ttl = 60,
            enabled = function() return Snacks.git.get_root() ~= nil end,
            cmd = [[git status --short --branch --renames --untracked-files=normal]],
        }
    },
}
