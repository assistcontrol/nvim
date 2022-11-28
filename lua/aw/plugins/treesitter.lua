if not AW.has('nvim-treesitter.configs') then return end

parsers = {'bash', 'go', 'html', 'javascript', 'json', 'lua', 'perl', 'regex', 'ruby', 'rust', 'scss', 'yaml'}

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
