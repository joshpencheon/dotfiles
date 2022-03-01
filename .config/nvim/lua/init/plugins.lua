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
  use 'tpope/vim-endwise'     -- do/end magic
  use 'tpope/vim-repeat'      -- better '.' support
  use 'tpope/vim-sleuth'      -- automatic identation
  use 'tpope/vim-surround'    -- brackets etc
  use 'tpope/vim-unimpaired'  -- pairs of mappings
  use 'tpope/vim-vinegar'     -- better netrw
  use 'f-person/git-blame.nvim' -- Inline Git blame
  use 'ojroques/vim-oscyank' -- OSC52 yank from server back to client clipboard.
  -- "gc" to comment visual regions/lines
  use {'numToStr/Comment.nvim',  config = function() require('Comment').setup() end }
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
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  -- use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- use 'rafamadriz/friendly-snippets'

  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'honza/vim-snippets'

  use 'christoomey/vim-tmux-navigator'
  use 'sjl/vitality.vim'

  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
