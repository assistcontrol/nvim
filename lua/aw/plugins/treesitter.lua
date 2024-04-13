-- Tree-sitter
local parsers = AW.is_root() and {} or {
    'go',
    'html',
    'javascript',
    'json',
    'luap',
    'perl',
    'regex',
    'ruby',
    'rust',
    'scss',
    'tmux',
    'v',
    'yaml'
}

return {
    'nvim-treesitter/nvim-treesitter',
    enabled = not vim.g.vscode,
    cmd   = {'TSInstall', 'TSInstallInfo', 'TSUpdate', 'TSUninstall'},
    event = {'BufReadPost', 'BufNewFile'},
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = parsers,

            highlight = {
                enable = true
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection   = '<Enter>',
                    node_incremental = '<Enter>',
                    node_decremental = '<BS>',
                }
            },

            indent = {
                enable = true
            },
        }
    end
}
