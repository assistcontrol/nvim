if not AW.has('nvim-autopairs') then return end

local pairs = require('nvim-autopairs')
local rule  = require('nvim-autopairs.rule')
local cond  = require('nvim-autopairs.conds')

pairs.setup {
    check_ts = true
}

pairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
pairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

pairs.add_rules({
    rule('%', '%', 'tt2html'):with_pair(cond.before_text('['), 1)
})
