local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { 'srcery-colors/srcery-vim', config = function() require('init.colours') end },
  { 'sunjon/shade.nvim', config = function() require('shade').setup() end },

  -- Git commands in nvim
  { 'tpope/vim-fugitive', config = function() require('init.statusbar') end },
  'tpope/vim-rhubarb', -- Fugitive-companion to interact with github
  'tpope/vim-repeat',      -- better '.' support
  'tpope/vim-sleuth',      -- automatic identation
  'tpope/vim-surround',    -- brackets etc
  'tpope/vim-unimpaired',  -- pairs of mappings
  'joshpencheon/vim-vinegar', -- better netrw

  -- auto-close brackets etc:
  { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end },
  -- OSC52 yank from server back to client clipboard.
  { 'ojroques/vim-oscyank', config = function() require('init.clipboard') end },
  'tversteeg/registers.nvim', -- preview of registers
  -- "gc" to comment visual regions/lines
  {'numToStr/Comment.nvim', config = function() require('Comment').setup() end },
  -- UI to select things (files, grep results, open buffers...)
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require('init.telescope') end },
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { "jose-elias-alvarez/buftabline.nvim", config = function() require('init.tabbar') end },
  -- Add git related info in the signs columns and popups
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require('init.git') end },
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  { 'nvim-treesitter/nvim-treesitter', config = function() require('init.treesitter') end },
  'nvim-treesitter/nvim-treesitter-textobjects', -- Additional textobjects for treesitter
  'RRethy/nvim-treesitter-endwise', -- automatic 'end' insertion
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  -- Autocompletion plugin
  { 'hrsh7th/nvim-cmp', config = function() require('init.completion') end },
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'saadparwaiz1/cmp_luasnip',
  'dcampos/nvim-snippy',
  'dcampos/cmp-snippy',
  'honza/vim-snippets',

  { 'folke/trouble.nvim', config = function() require('init.trouble') end },

  'junegunn/vim-easy-align',
  'junegunn/vim-peekaboo',
  'AndrewRadev/splitjoin.vim',

  'christoomey/vim-tmux-navigator',
  'sjl/vitality.vim',

  'tpope/vim-liquid',
  'tpope/vim-rails',
  'vim-ruby/vim-ruby',
  'hashivim/vim-terraform',
  { 'ray-x/go.nvim', config = function() require('init.go') end },

  -- Simulate smooth scrolling:
  { 'karb94/neoscroll.nvim', config = function() require('neoscroll').setup() end }
}, {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
