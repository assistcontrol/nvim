if not AW.has('nvim-treesitter.configs') then return end

require('nvim-treesitter.configs').setup {
    ensure_installed = {'bash', 'go', 'html', 'javascript', 'json', 'lua', 'perl', 'regex', 'ruby', 'scss', 'yaml'},
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
