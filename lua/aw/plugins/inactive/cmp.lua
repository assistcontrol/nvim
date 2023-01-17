if not AW.has('cmp') then return end

local cmp       = require('cmp')
local luasnip   = require('luasnip')
local lspconfig = require('lspconfig')
local nvim_lsp  = require('cmp_nvim_lsp')

cmp.setup {
    completion = {
        autocomplete = false,  -- Don't complete automatically
        completeopt = 'menu,menuone,noinsert'
    },
    confirmation = {default_behavior = cmp.ConfirmBehavior.Replace},
    formatting = {
        format = function(entry, vim_item)
            -- Name each source
            vim_item.menu = ({
                buffer     = '[Buffer]',
                calc       = '[Calc]',
                nvim_lsp   = '[LSP]',
                nvim_lua   = '[Lua]',
                path       = '[Path]',
                spell      = '[Spell]',
                treesitter = '[TS]'
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = {
        ['<C-n>'] = function()
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip and luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
                cmp.complete()
            end
        end,
        ['<C-p>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip and luasnip.expand_or_jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
                cmp.complete()
            end
        end,
        ['<C-c>'] = cmp.mapping.close()
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        --{name = 'treesitter'},  -- Slow, and may not even produce suggestions
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'luasnip'},
        {name = 'path'},
        {name = 'calc'},
        {name = 'buffer'},
        {name = 'spell'},
    }
}

-- Load language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_lsp.update_capabilities(capabilities)

lspconfig['gopls'].setup {capabilities = capabilities}
