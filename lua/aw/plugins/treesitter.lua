-- Tree-sitter
local parsers = {'c', 'lua', 'query', 'vim', 'vimdoc'} -- These MUST be listed, see treesitter/README.md
if not AW.is_root() then
    vim.list_extend(parsers, {
        'bash',
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
        'yaml'
    })
end

return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'hiphish/nvim-ts-rainbow2',
    cmd   = {'TSInstall', 'TSInstallInfo', 'TSUpdate', 'TSUninstall'},
    event = {'BufReadPost', 'BufNewFile'},
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = parsers,

            endwise = {
                enable = true
            },

            highlight = {
                enable = true
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<Enter>',
                    node_incremental = '<Enter>',
                    node_decremental = '<BS>'
                }
            },

            indent = {
                enable = true
            },

            rainbow = {
                enable = true,
                strategy = require('ts-rainbow.strategy.local')
            }
        }
    end
}
