-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    callback = function(args)
      vim.api.nvim_command("source" .. " " .. args.file)
      require('packer').sync()
    end,
    desc = "Sync plugins after updating plugins.lua",
    group = vim.api.nvim_create_augroup("Packer", {})
})

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use { 'srcery-colors/srcery-vim', config = [[require('init.colours')]] }
  use { 'tpope/vim-fugitive', config = [[require('init.statusbar')]] } -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-repeat'      -- better '.' support
  use 'tpope/vim-sleuth'      -- automatic identation
  use 'tpope/vim-surround'    -- brackets etc
  use 'tpope/vim-unimpaired'  -- pairs of mappings
  use 'joshpencheon/vim-vinegar' -- better netrw
  -- auto-close brackets etc:
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }
  use { 'ojroques/vim-oscyank', config = [[require('init.clipboard')]] } -- OSC52 yank from server back to client clipboard.
  use 'tversteeg/registers.nvim' -- preview of registers
  -- "gc" to comment visual regions/lines
  use {'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, config=[[require('init.telescope')]] }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "jose-elias-alvarez/buftabline.nvim", config = [[require('init.tabbar')
]] }
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = [[require('init.git')]] }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use { 'nvim-treesitter/nvim-treesitter', config = [[require('init.treesitter')]] }
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'RRethy/nvim-treesitter-endwise' -- automatic 'end' insertion
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use { 'hrsh7th/nvim-cmp', config = [[require('init.completion')]] } -- Autocompletion plugin
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'saadparwaiz1/cmp_luasnip'
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'honza/vim-snippets'

  use { 'folke/trouble.nvim', config = [[require('init.trouble')]] }

  use 'junegunn/vim-easy-align'
  use 'AndrewRadev/splitjoin.vim'

  use 'christoomey/vim-tmux-navigator'
  use 'sjl/vitality.vim'

  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'
  use 'hashivim/vim-terraform'
  use { 'ray-x/go.nvim', config = [[require('init.go')]] }

  -- Simulate smooth scrolling:
  use { 'karb94/neoscroll.nvim', config = function() require('neoscroll').setup() end }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
