return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
        'ray-x/cmp-treesitter',
        'onsails/lspkind-nvim',
    },
    event = 'InsertEnter',
    config = function()
        local cmp = require('cmp')
        cmp.setup {
            formatting = {
                format = function(_, item)
                    item.kind = AW.icon(item.kind, item.kind)
                    return item
                end
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
                ['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
                ['<C-g>'] = cmp.mapping.abort(),
                ['<CR>']  = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
                ['<S-Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
            }),

            sources = cmp.config.sources({
                {
                    name = 'nvim_lsp',
                    -- Don't show snippets
                    entry_filter = function(entry, ctx)
                        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Snippet'
                    end
                },
                {name = 'treesitter'},
                {name = 'nvim_lsp_signature_help'},
                {name = 'buffer'},
                {name = 'path'},
            }, {name = 'buffer'})
        }

        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                {name = 'buffer'}
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                {name = 'path'},
                {name = 'cmdline'},
            }, {name = 'cmdline'}
        })
    end,
}
