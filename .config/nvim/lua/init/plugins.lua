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
  { -- Primary colourscheme
    'rebelot/kanagawa.nvim',
    config = function() require('init.colours') end,
    priority = 1000
  },

  { -- Git commands in nvim
    'tpope/vim-fugitive',
    config = function() require('init.statusbar') end
  },

  'tpope/vim-rhubarb',        -- Fugitive-companion to interact with github
  'tpope/vim-repeat',         -- better '.' support
  'tpope/vim-sleuth',         -- automatic identation
  'tpope/vim-surround',       -- brackets etc
  'tpope/vim-unimpaired',     -- pairs of mappings
  'joshpencheon/vim-vinegar', -- better netrw

  { -- auto-close brackets etc:
    'windwp/nvim-autopairs',
    config = true
  },

  { -- OSC52 yank from server back to client clipboard.
    'ojroques/vim-oscyank',
    config = function() require('init.clipboard') end
  },

  'tversteeg/registers.nvim', -- preview of registers

  { -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    config = true
  },

  { -- UI to select things (files, grep results, open buffers...)
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim'
    },
    config = function() require('init.telescope') end
  },

  { -- fzf-like behaviour in Telescope finders
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  { -- creates a "tab bar" of buffers
    'jose-elias-alvarez/buftabline.nvim',
    config = function() require('init.tabbar') end
  },

  { -- Add git related info in the signs columns and popups
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('init.git') end
  },

  { -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter',
    config = function() require('init.treesitter') end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects', -- Additional textobjects for treesitter
      'RRethy/nvim-treesitter-endwise',              -- automatic 'end' insertion
      'nvim-treesitter/nvim-treesitter-context',     -- context when scrolling up
    }
  },

  { -- LSP client configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',           -- LSP server manager
      'williamboman/mason-lspconfig.nvim', -- have the two place nice
    }
  },

  { -- Autocompletion plugin
    'hrsh7th/nvim-cmp',
    config = function() require('init.completion') end,
    dependencies = {
      'hrsh7th/cmp-buffer',                  -- use buffer as a completion source
      'hrsh7th/cmp-path',                    -- allow paths to be cuompleted
      'hrsh7th/cmp-cmdline',                 -- allow commands to be completed
      'hrsh7th/cmp-nvim-lsp',                -- LSP client completion source
      'hrsh7th/cmp-nvim-lsp-signature-help', -- LSP client completion source for signatures
    }
  },

  { -- Snippets behaviour
    'dcampos/nvim-snippy',
    dependencies = {
      'dcampos/cmp-snippy', -- integrates with cmp
      'honza/vim-snippets', -- source of snippets
    }
  },

  { -- Presentation of vim.diagnostics
    'folke/trouble.nvim',
    config = function() require('init.trouble') end
  },

  'junegunn/vim-easy-align',   -- bulk formatting
  'junegunn/vim-peekaboo',     -- register previewing
  'AndrewRadev/splitjoin.vim', -- e.g. inline/multiline toggling

  'christoomey/vim-tmux-navigator', -- navigate between nvim/tmux splits
  'sjl/vitality.vim',               -- restore Focus* events from within tmux

  'tpope/vim-liquid',        -- Nicer support of liquid tags for e.g. Jekyll
  'tpope/vim-rails',         -- extensions for Ruby on Rails projects
  'vim-ruby/vim-ruby',       -- enhanced Ruby support
  'hashivim/vim-terraform',  -- highlighting for HCL

  { -- Improved Golang support
    'ray-x/go.nvim',
    config = function() require('init.go') end
  },
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
