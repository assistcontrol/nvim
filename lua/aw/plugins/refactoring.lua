return {
    'theprimeagen/refactoring.nvim',
    dependencies = {AW.deps.plenary, AW.deps.treesitter},
    ft = {'javascript', 'lua', 'go', 'ruby'},
    config = function()
        require('refactoring').setup {}

        require('telescope').load_extension('refactoring')
    end
}
