-- LSP status as corner float
return {
    'j-hui/fidget.nvim',
    enabled = not AW.is_root(),
    tag = 'legacy',
    event = 'LspAttach',
    opts = {
        text = {spinner = 'dots_negative'}
    }
}
