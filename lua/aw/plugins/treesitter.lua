if not AW.has('nvim-treesitter.configs') then return end

parsers = {
    'c', 'help', 'lua', 'vim',  -- These MUST be listed, see treesitter/README.md
    'bash', 'go', 'html', 'javascript', 'json', 'perl', 'regex', 'ruby', 'rust', 'scss', 'yaml'
}

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
