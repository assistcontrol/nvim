-- Tree-sitter
local parsers = AW.is_root() and {} or {
    'bash',
    'comment',  -- NOTE: INFO: WARN: ERROR: etc
    'css',
    'diff',
    'gitcommit',
    'go',
    'html',
    'hurl',
    'javascript',
    'jsdoc',
    'json',
    'perl',
    'python',
    'ruby',
    'rust',
    'scss',
    'tmux',
    'yaml',

    -- Infrequent
    'awk',
    'cpp',
    'c_sharp',
    'editorconfig',
    'git_config',
    'git_rebase',
    'gitignore',
    'gomod',
    'gosum',
    'luap',
    'powershell',
    'printf',
    'regex',
    'robots',
    'sql',
    'toml',
    'typescript',
    'typst',
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
