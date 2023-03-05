-- Loop closure (named end etc. blocks)
return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        local pairs = require('nvim-autopairs')
        local rule  = require('nvim-autopairs.rule')
        local cond  = require('nvim-autopairs.conds')

        pairs.setup {
            check_ts = true,
            map_cr   = false
        }

        pairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
        pairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

        pairs.add_rules({
            rule('%', '%', 'tt2html'):with_pair(cond.before_text('['), 1)
        })
    end
}
