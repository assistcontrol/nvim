# NeoVim dotfiles
The One True Config for the One True Editor

Put this in somewhere like `~/src/vim`. Then add the path to the `runtimepath` in your `~/.config/nvim/init.lua`:

```lua
vim.opt.runtimepath:prepend('~/src/vim')
require('init')
```
