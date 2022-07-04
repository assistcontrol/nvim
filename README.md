# NeoVim dotfiles
One True Config for the One True Editor

`~/.config/nvim/init.lua` just needs to add this repo to `runtimepath`
and then load its `init.lua`:

```lua
vim.opt.runtimepath:prepend('~/build/vim')
require('aw')
```
