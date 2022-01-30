# NeoVim dotfiles
The One True Config for the One True Editor

Put this in a `.../lua/` subdirectory, like `~/src/vim/lua`. Then add the enclosing path (without `/lua`) to the `runtimepath` in your `~/.config/nvim/init.lua`:

```lua
vim.opt.runtimepath:prepend('~/src/vim')
require('init')
```
