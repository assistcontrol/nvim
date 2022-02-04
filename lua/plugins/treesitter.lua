require('nvim-treesitter.configs').setup {
    ensure_installed = {'bash', 'go', 'html', 'javascript', 'json', 'lua', 'perl', 'regex', 'ruby', 'rust', 'scss', 'yaml'},
    highlight = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true
    }
}