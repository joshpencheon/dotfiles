-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
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
  use 'f-person/git-blame.nvim' -- Inline Git blame
  use 'ojroques/vim-oscyank' -- OSC52 yank from server back to client clipboard.
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
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
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
end)

require("buftabline").setup {
  tab_format = " #{b}#{f} ",
  hlgroups = {
    current = "TabLineSel",
    normal  = "TabLine",
    active  = "TabLineActive",
    spacing = "TabLineFill",
  }
}

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

-- vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.shortmess = 'FIat'

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme
vim.o.termguicolors = true

vim.opt.listchars = {
  space = '⋅',
  trail = '█',
  tab = '▸ ',
  extends = '»',
  precedes = '«',
}
vim.opt.list = true

-- A note on clipboards: NeoVim's default clipboard provider will
-- try and use `pbcopy` on macOS, but will eventually fall back to
-- tmux's buffer.
--
-- Because we prefer the unnamedplus register, NeoVim will yank to
-- and paste from one of these clipboard buffers by default.
--
-- It is already the case that tmux will use OSC52 codes to tell iTerm
-- to try to update the client clipboard; we use a plugin to do something
-- similar in NeoVim - emitting OSC52 codes when yanking into the unnamed
-- register. This means things mostly 'just work' when accessing NeoVim
-- over SSH.

-- Use system (+ selection) clipboard by default:
vim.cmd [[ set clipboard^=unnamed,unnamedplus ]]

vim.cmd [[
  let g:oscyank_silent=1

  " Automatically emit the OSC52 control sequence when yanking:
  augroup oscyank
    autocmd!
    autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif
  augroup END
]]

-- Inline git blame (could this also be done with the signs plugin?)
vim.g.gitblame_message_template = ' « <date>: <summary> [<sha>]'
vim.g.gitblame_date_format = '%r'
vim.g.gitblame_highlight_group = 'GitBlame'

vim.cmd [[
  let g:srcery_inverse=0
  colorscheme srcery

  set termguicolors
  set noshowmode " Don't show '--INSERT--' etc

  highlight Normal         guibg=black
  highlight LineNr         guibg=black
  highlight CursorLine     guibg=black
  highlight CursorLineNr   guibg=black
  highlight VertSplit      guibg=black guifg=#918175

  highlight Visual guibg=darkgreen

  highlight TabLineSel    guifg=white    guibg=black gui=bold
  highlight TabLineActive guifg=#999999  guibg=black gui=NONE
  highlight TabLine       guifg=#555555  guibg=black gui=NONE
  highlight TabLineFill   guibg=black

  highlight Statusline    guifg=white   guibg=#191919 gui=bold
  highlight StatusLineGit guifg=#98BC37 guibg=#191919 gui=bold
  highlight StatuslineNC  guifg=#555555 guibg=#191919 gui=NONE

  highlight StatusLine_insert  guibg=skyblue    gui=bold guifg=black
  highlight StatusLine_visual  guibg=darkgreen  gui=bold
  highlight StatusLine_replace guibg=darkred    gui=bold
  highlight StatusLine_command guibg=darkorange gui=bold guifg=black

  highlight TermCursor   guifg=#BB0000
  highlight TermCursorNC guibg=#550000

  highlight NonText    guifg=#333333
  highlight SpecialKey guifg=#333333

  highlight SignColumn guibg=black

  highlight IncSearch guibg=#333333

  highlight GitSignsAdd    guifg=green
  highlight GitSignsChange guifg=yellow
  highlight GitSignsDelete guifg=red

  highlight ALEErrorSign   guifg=#000000 guibg=#FF0000
  highlight ALEWarningSign guifg=#000000 guibg=#FFFF00
  highlight link ALEError   ALEErrorSign
  highlight link ALEWarning ALEWarningSign

  highlight GitBlame guifg=#333333
]]

-- Magic status bar style:
vim.cmd [[
  function! MagicStatus(n, focus)
    let mode   = mode()
    let active = winnr() == a:n

    if a:focus == 0
      " de-emphasise all status lines when Vim looses focus
      let group = 'StatusLineNC'
      let git_group = group
    elseif active
      " Style just the status line of the active window:
      if mode == 'i'
        let group     = 'StatusLine_insert'
        let git_group = group
      elseif mode == 'v' || mode == 'V' || mode == "\<C-v>"
        let group = 'StatusLine_visual'
        let git_group = group
      elseif mode == 'r' || mode == 'R'
        let group = 'StatusLine_replace'
        let git_group = group
      elseif mode == 'c'
        let group = 'StatusLine_command'
        let git_group = group
      else
        let group     = 'StatusLine'
        let git_group = 'StatusLineGit'
      endif
    else
      " de-emphasise all non-active windows.
      let group = 'StatusLineNC'
      let git_group = group
    endif

    return '%#' . group . '#' . (active ? '»' : '«') . ' %f ' . (active ? '«' : '»') . (active ? '%=%#' . git_group . '#%{fugitive#head(8)}%#' . group . '#  %l:%v ' : '')
  endfunction

  function! s:RefreshStatuses(focus)
    for nr in range(1, winnr('$'))
      call setwinvar(nr, '&statusline', '%!MagicStatus(' . nr . ', ' . a:focus .')')
    endfor
  endfunction

  augroup status
    autocmd!
    autocmd FocusLost                                              * call <SID>RefreshStatuses(0)
    autocmd FocusGained,VimEnter,WinEnter,BufWinEnter,CmdlineEnter * call <SID>RefreshStatuses(1)
  augroup END
]]

vim.o.wildmode = 'longest,list'
vim.o.completeopt = 'longest'

--Enable Comment.nvim
require('Comment').setup()

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 500})
  augroup end
]]

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '∙' },
    change = { text = '∙' },
    delete = { text = '∙' },
    topdelete = { text = '∙' },
    changedelete = { text = '∙' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>w', [[<cmd>w<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', [[<cmd>try|bp|bd #|close|catch|endtry<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', [[<cmd>lua require('telescope.builtin').git_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>O', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>A', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>a', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- vim: ts=2 sts=2 sw=2 et
