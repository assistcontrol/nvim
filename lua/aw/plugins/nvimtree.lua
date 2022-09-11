if not AW.has('nvim-tree') then return end

require('nvim-tree').setup {
    hijack_cursor = true,

    diagnostics = {
        enable = true
    }
}
