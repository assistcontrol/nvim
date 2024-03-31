return {
    'mhartington/formatter.nvim',
    enabled = not AW.is_root(),
    ft = {'v'},
    config = function()
        require('formatter').setup {
            logging = false,
            filetype = {
                v = {
                    function()
                        return {
                            exe = 'v',
                            args = {'fmt', '-w'},
                            stdin = true,
                        }
                    end,
                },
            },
        }

        vim.cmd [[autocmd BufWritePost *.v FormatWrite]]
    end,
}
