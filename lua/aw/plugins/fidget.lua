-- LSP status as corner float
return {
    'j-hui/fidget.nvim',
    event = 'BufReadPre',
    opts = {
        text = {spinner = 'dots_negative'}
    }
}
