--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

vim.o.linebreak = true

--When wrapping, move by display lines
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.shortmess = 'FIat'

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

vim.wo.signcolumn = 'yes'

vim.opt.listchars = {
  space = '⋅',
  trail = '█',
  tab = '▸ ',
  extends = '»',
  precedes = '«',
}
vim.opt.list = true
