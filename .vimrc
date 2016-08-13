" We must iMprove things:
set nocompatible

let mapleader = " "

call plug#begin('~/.vim/plugged')
  " colour scheme:
  Plug 'roosta/srcery'

  " { Use FZF for searching, if installed
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    let g:fzf_layout = { 'window': 'enew' }

    nnoremap <Leader>o :Files<CR>
    nnoremap <Leader>a :Ag<CR>
    nnoremap <Leader>b :Buffers<CR>
  " }

  " Preview register contents
  Plug 'junegunn/vim-peekaboo'

  " { better autochdir
    Plug 'airblade/vim-rooter'

    let g:rooter_use_lcd = 1       " :lcd for current window
    let g:rooter_silent_chdir = 1  " don't report action
    let g:rooter_resolve_links = 1 " follow symlinks
  " }

  " tab completion / snippet engine / snippets:
  Plug 'ervandew/supertab'
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  " { Status / Tab bars:
    Plug 'itchyny/lightline.vim'
    Plug 'ap/vim-buftabline'

    set noshowmode " Don't show '--INSERT--' etc

    let g:buftabline_indicators = 1 " Add '+' to modified buffers in the tabline
    let g:lightline = {
      \ 'active': {
      \   'left':  [[ 'mode', 'paste' ], [ 'modified', 'filename' ]],
      \   'right': []
      \ },
      \ 'inactive': {
      \   'left':   [[ 'filename', 'modified' ]],
      \   'right':  []
      \ },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator':    { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
  " }

  " Tmux / vim integration:
  Plug 'christoomey/vim-tmux-navigator'

  " Better iTerm2 / tmux support:
  Plug 'sjl/vitality.vim'

  " tpope collection:
  Plug 'tpope/vim-sensible'   " let's agree
  Plug 'tpope/vim-vinegar'    " improve netrw
  Plug 'tpope/vim-endwise'    " do/end magic
  Plug 'tpope/vim-fugitive'   " Git inside vim
  Plug 'tpope/vim-repeat'     " better '.' support
  Plug 'tpope/vim-surround'   " brackets etc
  Plug 'tpope/vim-commentary' " block [un]commenting
  Plug 'tpope/vim-dispatch'   " asynchronous tasks
  Plug 'tpope/vim-unimpaired' " pairs of mappings

  " auto-close brackets etc:
  Plug 'jiangmiao/auto-pairs'

  " { visual select expand/shrink:
    Plug 'terryma/vim-expand-region'

    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)
  " }

  " Ruby object support:
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'

  " Additional language / env support:
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'kchmck/vim-coffee-script'
  Plug 'elixir-lang/vim-elixir'
  Plug 'vim-ruby/vim-ruby'

  Plug 'AndrewRadev/splitjoin.vim' " single / multiline toggles
  Plug 'AndrewRadev/switch.vim'    " switch hash flavours, etc
call plug#end()

set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler " show the cursor position all the time

" Basic setup:
syntax on
filetype plugin indent on

" Use system (+ selection) clipboard by default:
set clipboard^=unnamed,unnamedplus

" Improve performance:
set ttyfast " Defaults to on already with neovim
set regexpengine=1
set lazyredraw

" No splash screen, use abbreviations,
" truncate if needed, don't give file info
set shortmess=IatF

" Allow switching away from unsaved buffers
set hidden

" NetRW should :cd
let g:netrw_keepdir = 0

" disable Background Color Erase (BCE)
if &term =~ '256color'
  set t_ut=
endif

" Enable matchit runtime for ruby text-objects:
runtime macros/matchit.vim

" always show status bar:
set laststatus=2
set showtabline=2
set guioptions-=e

" When tab-completing commands, don't just cycle:
set wildmode=longest,list

" Avoid delay coming out of INSERT mode, but without weirdness:
set timeout timeoutlen=1000 ttimeoutlen=10

" Give choices when closing without write:
set confirm

" delete comment character when joining commented line:
set formatoptions+=j

" allow the cursor to move beyond the line end in all modes:
set virtualedit=all

" disable the arrow keys for navigation!
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" In insert mode, make Ctrl-c exit whilst triggering autocmds
" and stop the cursor jumping. In visual mode, allow <C-c> to
" work with block inserts / appends.
inoremap <C-c> <Esc>`^
vnoremap <C-c> <Esc>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set scrolloff=2  " Keep cursor 2 lines from boundary when scrolling
set sidescroll=1 " Don't re-center the cursor when scrolling long lines

" searching {
  set nohlsearch           " don't highlight all matches
  set incsearch            " realtime highlighting
  set completeopt=longest  " don't show menu for inc complete
" }

" whitespace controls {
  set backspace=indent,eol,start
  set tabstop=2 shiftwidth=2 expandtab
  set nofoldenable " disable code folding
  set nowrap       " don't text-wrap
" }

" invisibles {
  set listchars=space:⋅,trail:█,tab:▸\ ,extends:»,precedes:«
  set list
" }

" Configure UI {
  set t_Co=256
  set background=dark

  set termguicolors
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  let g:srcery_inverse=0
  colorscheme srcery

  set fillchars=vert:\  " blank vertical split, looks nicer than pipe

  set number     " show absolute line numbers...
  set cursorline " ...and highlight the current one.

  highlight Normal guibg=black
  highlight LineNr guibg=black
  highlight CursorLine guibg=black
  highlight CursorLineNr guibg=black
  highlight BufTabLineFill guibg=black

  highlight Visual guibg=darkgreen

  highlight BufTabLineCurrent guifg=#1B1B1B  guibg=darkgray
  highlight BufTabLineActive  guifg=darkgray guibg=#1B1B1B
  highlight BufTabLineHidden  guifg=#333333  guibg=#1B1B1B
" }

" Strip trailing whitespace, and restore cursor {
  fun! TrimWhitespace()
      let l:save_cursor = getpos('.')
      %s/\s\+$//e
      call setpos('.', l:save_cursor)
  endfun
" }

" Leader maps {
  nnoremap <Leader>c :lcd %:p:h<CR>
  nnoremap <Leader>w :w<CR>
  nnoremap <Leader>q :bd<CR>
  nnoremap <Leader>s :call TrimWhitespace()<CR>
" }
