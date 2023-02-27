return {
  'zbirenbaum/copilot.lua',
  enabled = not AW.is_root(),
  event = 'BufEnter',
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept  = '<C-y>',
        next    = '<C-]>',
        prev    = '<C-[>',
        dismiss = false
      }
    },
    panel = {
      enabled = false
    }
  }
}
