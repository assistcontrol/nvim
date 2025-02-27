if vim.g.vscode then return {enabled = false} end

local date = function()
    return os.date('%a %Y/%m/%d %H:%M')
end

local item = function(key, desc, icon, action)
    return { key = key, desc = desc, icon = AW.icon(icon), action = action, indent = 2 }
end

local newSection = function()
    return { title = '' }
end

local title = function(str)
    return { title = str }
end

local version = function()
    local version = vim.version()
    return string.format('nvim v%d.%d.%d', version.major, version.minor, version.patch)
end

local GIT = {
    status = [[git status --short --branch --renames --untracked-files=normal]],
    log    = [[git --no-pager log --color=always --format="%C(red)🔹 %h %C(brightblue)%ad %C(reset)%s" --date=format:"%y/%m/%d"]],
}

return {
    preset = {
        header = version(),
        keys = {
            title('Common'),
            item('i', 'New file', 'new', [[:enew]]),
            item('q', 'Quit nvim', 'quit', [[:qall]]),

            newSection(),
            title('Update'),
            item('U', 'Update plugins',     'plug', [[:lua AW.update_plugins()]]),
            item('G', 'Update go binaries', 'go',   [[:GoUpdateBinaries]]),
            item('T', 'Update parsers',     'tree', [[:TSUpdate]]),

            newSection(),
            title('Browse'),
            item('b', 'Browse',    'folder',   [[:lua AW.filebrowser()]]),
            item('x', 'tree',      'filetree', [[:lua Snacks.picker.explorer({layout = {preset = 'default', preview = true}})]]),
            item('g', 'live grep', 'search',   [[:lua Snacks.picker.grep()]]),
            item('r', 'recent',    'recent',   [[:lua Snacks.picker.recent()]]),
            item('n', 'ninja',     'ninja',    [[:lua AW.filebrowser('~/build/ninja')]]),
            item('d', 'dotfiles',  'dotfiles', [[:lua AW.filebrowser('~/build/dotfiles')]]),
            item('v', 'vim',       'vim',      [[:lua AW.filebrowser('~/build/nvim/lua/aw')]]),
        },
    },

    sections = {
        { title = version(), padding = {2, 0}, align = 'right' },

        { section = 'keys' },

        { pane = 2, title = date(), padding = {2, 0}, align = 'left' },

        { pane = 2, title = 'Projects', section = 'projects', icon = AW.icon('recent'), indent = 2 },

        { pane = 2, title = '', padding = 0 },
        { pane = 2, section = 'terminal', icon = AW.icon('git'), title = 'Git Log', indent = 2, height = 7,
            enabled = function() return Snacks.git.get_root() ~= nil end,
            cmd = GIT.log,
        },

        { pane = 2, title = '', padding = 0 },
        { pane = 2, section = 'terminal', icon = '', title = 'Git Status', indent = 5, ttl = 30,
            enabled = function() return Snacks.git.get_root() ~= nil end,
            cmd = GIT.status,
        },

    },
}
