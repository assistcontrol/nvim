-- Tree-sitter
local parsers = AW.is_root() and {} or {
    'bash',
    'comment',  -- NOTE: INFO: WARN: ERROR: etc
    'css',
    'diff',
    'editorconfig',
    'gitcommit',
    'go',
    'html',
    'hurl',
    'javascript',
    'jsdoc',
    'json',
    'perl',
    'python',
    'ruby',
    'rust',
    'scss',
    'templ',
    'yaml',

    -- Infrequent
    'awk',
    'cpp',
    'c_sharp',
    'git_config',
    'git_rebase',
    'gitignore',
    'gomod',
    'gosum',
    'luap',
    'powershell',
    'printf',
    'regex',
    'robots_txt',
    'sql',
    -- 'swift', -- Disabled until treesitter works with rust 1.87
    'toml',
    'typescript',
    'typst',
}

return {
    'nvim-treesitter/nvim-treesitter',
    enabled = not vim.g.vscode,
    branch = 'main',
    lazy  = false,
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')

        -- Install missing parsers asynchronously.
        ts.install(parsers)

        -- Enable tree-sitter for buffers with installed parsers
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('AWTreeSitter', {}),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match) or args.match

                if not vim.treesitter.language.add(lang) then
                    return
                end

                -- Highlighting
                vim.treesitter.start(args.buf, lang)

                -- Indentation (where a query exists)
                if vim.treesitter.query.get(lang, 'indents') then
                    vim.bo[args.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                end

                -- Incremental selection
                local opts = { buffer = args.buf }

                vim.keymap.set('n', '<CR>', function()
                    vim.treesitter.select('parent')
                end, opts)

                vim.keymap.set('x', '<CR>', function()
                    vim.treesitter.select('parent')
                end, opts)

                vim.keymap.set('x', '<BS>', function()
                    vim.treesitter.select('child')
                end, opts)
            end,
        })
    end,
}
