-- vim: sw=4
-- Tree-sitter
local parsers = {'c', 'help', 'lua', 'vim'} -- These MUST be listed, see treesitter/README.md
if not AW.is_root() then
    vim.list_extend(parsers, {
        'bash', 'go', 'html', 'javascript', 'json', 'perl', 'regex', 'ruby', 'rust', 'scss', 'yaml'
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
