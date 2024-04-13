if not AW.has('mini.tabline') then return end
if vim.g.vscode then return end

require('mini.tabline').setup {}
