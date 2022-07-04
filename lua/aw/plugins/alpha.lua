local dashboard = require('alpha.themes.dashboard')
local icon = require('aw/util').icon

local pwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':~:.')
if pwd == '' then pwd = '~/' end

vim.cmd('autocmd Filetype alpha setlocal fillchars=eob:\\ ')  -- Hide tildes at bottom

dashboard.section.buttons.val = {
    dashboard.button('i', icon('new', 'New file'),          '<cmd>ene <BAR> startinsert <CR>'),
    dashboard.button('q', icon('close', 'Quit nvim'),       '<cmd>qa<CR>'),
    dashboard.button('U', icon('plug', 'Update plugins'),   '<cmd>PackerSync<CR>'),
    dashboard.button('G', icon('go', 'Update go binaries'), '<cmd>GoUpdateBinaries<CR>'),
    dashboard.button('b', icon('folder', pwd),              string.format([[<cmd>lua DashboardBrowse('%s')<CR>]], pwd)),
    dashboard.button('r', icon('recent', 'Recent'),         '<cmd>Telescope oldfiles<CR>'),
    dashboard.button('m', icon('folder', 'med_apps'),       '<cmd>lua DashboardBrowse("~/build/med_apps")<CR>'),
    dashboard.button('d', icon('dotfiles', 'dotfiles'),     '<cmd>lua DashboardBrowse("~/build/dotfiles")<CR>'),
    dashboard.button('v', icon('vim', 'vim'),               '<cmd>lua DashboardBrowse("~/build/vim/lua")<CR>'),
}

dashboard.section.header.val = {
    [[           NeoVim           ]],
    [[────────────────────────────]]   -- \u2500
}
dashboard.section.footer.val = os.date()
require('alpha').setup(dashboard.config)

-- Helper functions
function DashboardBrowse(dir)
    vim.cmd('lcd ' .. dir)
    require('telescope.builtin').find_files()
end
