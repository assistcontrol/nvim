return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },
  event = 'InsertEnter',
  opts = function()
    local cmp = require('cmp')
    return {
      completion = {
        completeopt = 'menu,menuone,noinsert'
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
        ['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-g>'] = cmp.mapping.abort(),
        ['<CR>']  = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim-lsp'},
        { name = 'luasnip'},
        { name = 'buffer'},
        { name = 'path'}
      })
    }
  end,
}
