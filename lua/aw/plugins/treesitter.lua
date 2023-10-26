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
