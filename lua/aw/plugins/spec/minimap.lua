if not AW.has('mini.map') then return end
if vim.g.vscode then return end

local mmap = require('mini.map')

mmap.setup {
    integrations = {
        mmap.gen_integration.builtin_search(),
        mmap.gen_integration.gitsigns(),
        mmap.gen_integration.diagnostic()
    },

    symbols = {
        encode = mmap.gen_encode_symbols.dot('3x2'),

        scroll_line = '▶',
    },

    window = {
        show_integration_count = false,

        winblend = 100
    }
}
