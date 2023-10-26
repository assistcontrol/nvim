vim.g.user_emmet_settings = {
    -- New line for all tags
    html = {block_all_childless = true}
}

return {
    'mattn/emmet-vim',
    enabled = not AW.is_root(),
    ft = {'html', 'tt2html'}
}
