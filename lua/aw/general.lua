-- General vim configuration
vim.g.c_comment_strings = true
vim.g.vimsyn_embed = 'l'  -- Syntax highlight embedded lua

vim.opt.cursorline  = true     -- Highlight current line
vim.opt.inccommand  = 'split'  -- Show substitutions live in a split
vim.opt.infercase   = true     -- 'smartcase' for keyword completion
vim.opt.lazyredraw  = true     -- Don't redraw screen for outputless commands
vim.opt.joinspaces  = false    -- Don't insert 2 spaces after '.' on join
vim.opt.modeline    = true     -- First line:  # vim: ft=[...]
vim.opt.number      = true     -- Show line numbers
vim.opt.pumblend    = AW.ui.winblend
vim.opt.report      = 0        -- Report all file changes
vim.opt.scrolljump  = 2        -- Min # of lines to scroll past screen
vim.opt.scrolloff   = 2        -- Show this many lines around cursor
vim.opt.showmatch   = true     -- Briefly flash matching bracket
vim.opt.sidescroll  = 2        -- Min # of columns to scroll horizontally
vim.opt.splitbelow  = true     -- Open horizontal splits below
vim.opt.splitright  = true     -- Open vertical splits to the right
vim.opt.virtualedit = 'block'  -- Able to select nonexistent chars in v-block mode
vim.opt.visualbell  = true     -- Do not *beep*ing beep
vim.opt.winblend    = AW.ui.winblend
vim.opt.fillchars:append({eob = ' ',
    horiz = ' ', horizup = ' ', horizdown = ' ', vert = ' ', vertleft = ' ', vertright = ' ', verthoriz = ' '})
vim.opt.formatoptions:remove({'o', 'r'})  -- Don't auto-comment new lines

-- Mosh < 1.4 mangles truecolor to the point that termguicolors is unusable.
-- I only use mosh to connect to FreeBSD systems, so it suffices for me simply
-- to check the OS. This can be removed if mosh 1.4 comes out, which might
-- never actually happen at this point.
vim.opt.termguicolors = vim.loop.os_uname().sysname ~= 'FreeBSD'

-- Searching
vim.opt.grepprg    = 'grep --line-number --with-filename $*'
vim.opt.ignorecase = true   -- Ignore case in search patterns
vim.opt.smartcase  = true   -- Override 'ignorecase' when pattern has upper-case characters
vim.opt.wildignore:append({'*/node_modules/*', '*/.git/*'})

-- Tabbing/indenting (overridden prn in filetypes.lua)
vim.opt.expandtab   = true
vim.opt.shiftround  = true     -- Indent to multiple of shiftwidth
vim.opt.shiftwidth  = 2
vim.opt.softtabstop = 2
vim.opt.tabstop     = 2

-- Line breaks
vim.opt.linebreak = true       -- Wrap long lines at word boundaries
vim.opt.showbreak = '+'        -- Gutter string before wrapped lines
vim.opt.whichwrap = 'b,s,h,l'  -- Keys allowed to move across lines

-- Status line
vim.opt.cmdheight   = 1                    -- Status bar is not included here
vim.opt.showmode    = false                -- Unnecessary with status line plugins
vim.opt.wildmode    = 'longest:full,full'  -- Tab through menus
vim.opt.statusline  = '%F%m%r%h%w %y [%p%%/%L] [%04v @ %04l]%a'

-- Winbar
-- Hopefully VimR realizes soon that Neovim got an update
if vim.fn.has('nvim-0.8') > 0 then
    require('aw/winbar')
    vim.opt.laststatus = 3
else
    vim.opt.laststatus = 2
end

-- Spellchecking
vim.cmd('syntax spell toplevel')  -- Only check non-syntax text
vim.opt.spellfile = '~/build/dotfiles/vim/dictionary/dictionary.utf-8.add'

-- Folding
vim.opt.foldclose  = 'all'
vim.opt.foldmethod = 'marker'
vim.opt.foldopen:append('jump')

-- netrw
vim.g.netrw_banner    = 0
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]  -- Hide dotfiles by default
vim.g.netrw_liststyle = 3      -- Tree-style listing

-- Performance
vim.opt.timeoutlen  = 500      -- Wait time for map sequences
vim.opt.ttimeoutlen = 10       -- Wait time for keycode sequences
vim.opt.updatetime  = 100      -- Low is good for async

-- Neovide
if vim.g.neovide then
    vim.opt.guifont = 'JetBrainsMono Nerd Font:sb:h12'
    vim.g.neovide_cursor_animation_length = 0.02
    vim.g.neovide_cursor_vfx_mode         = 'pixiedust'
    vim.g.neovide_cursor_vfx_particle_density = 25.0
end
