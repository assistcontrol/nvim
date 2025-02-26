-- LSP status as corner float
return {
    'j-hui/fidget.nvim',
    enabled = not AW.is_root(),
    event = 'LspAttach',
    opts = {
        progress = {
            display = {
                done_ttl = 6,
                progress_icon = {'dots_negative'},
            },
        },
    }
}
