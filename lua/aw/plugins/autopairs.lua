local pairs = require('nvim-autopairs')
local rule  = require('nvim-autopairs.rule')

pairs.setup {
    check_ts = true
}

pairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
pairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

pairs.add_rules({
    -- rule('[%', '%]', 'tt2html')
    rule('%', '%', 'tt2html')
})
