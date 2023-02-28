-- vim: sw=4
-- Tree-sitter
local parsers = {
    'c', 'help', 'lua', 'vim',  -- These MUST be listed, see treesitter/README.md
    'bash', 'go', 'html', 'javascript', 'json', 'perl', 'regex', 'ruby', 'rust', 'scss', 'yaml'
}

return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'mrjones2014/nvim-ts-rainbow',
    cmd   = {'TSInstall', 'TSInstallInfo', 'TSUpdate', 'TSUninstall'},
    event = {'BufReadPost', 'BufNewFile'},
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = AW.is_root() and {} or parsers,
            endwise = {
                enable = true
            },
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
            rainbow = {
                enable = true,
                extended_mode = true
            }
        }
    end
}
