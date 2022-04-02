-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'srcery-colors/srcery-vim'
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-repeat'      -- better '.' support
  use 'tpope/vim-sleuth'      -- automatic identation
  use 'tpope/vim-surround'    -- brackets etc
  use 'tpope/vim-unimpaired'  -- pairs of mappings
  use 'joshpencheon/vim-vinegar' -- better netrw
  use 'f-person/git-blame.nvim' -- Inline Git blame
  -- auto-close brackets etc:
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }
  use 'ojroques/vim-oscyank' -- OSC52 yank from server back to client clipboard.
  use 'tversteeg/registers.nvim' -- preview of registers
  -- "gc" to comment visual regions/lines
  use {'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "jose-elias-alvarez/buftabline.nvim" }
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'RRethy/nvim-treesitter-endwise' -- automatic 'end' insertion
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'saadparwaiz1/cmp_luasnip'
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'honza/vim-snippets'

  use 'junegunn/vim-easy-align'

  use 'christoomey/vim-tmux-navigator'
  use 'sjl/vitality.vim'

  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'
  use 'hashivim/vim-terraform'

  -- Simulate smooth scrolling:
  use { 'karb94/neoscroll.nvim', config = function() require('neoscroll').setup() end }

  if packer_bootstrap then
    require('packer').sync()
  end
end)