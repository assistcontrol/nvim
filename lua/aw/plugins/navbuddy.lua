return {
    'smiteshp/nvim-navbuddy',
    dependencies = {AW.deps.nui, 'smiteshp/nvim-navic'},
    opts = {
        window = {
            border = 'none',
        },

        lsp = {
            auto_attach = true
        }
    }
}
