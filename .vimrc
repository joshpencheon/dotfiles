" We must iMprove things:
set nocompatible " ignored by NeoVim

let mapleader = " "

call plug#begin('~/.vim/plugged')
  " theme:
  Plug 'junegunn/seoul256.vim'

  " { Use FZF for searching, if installed
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    let g:fzf_layout = { 'up': '~50%' }

    nnoremap <Leader>o :Files!<CR>
    nnoremap <Leader>a :Ag!<CR>
    nnoremap <Leader>b :Buffers<CR>
  " }

  " Preview register contents
  Plug 'junegunn/vim-peekaboo'

  " { better autochdir
    Plug 'airblade/vim-rooter'

    let g:rooter_use_lcd = 1       " :lcd for current window
    let g:rooter_silent_chdir = 1  " don't report action
    let g:rooter_resolve_links = 1 " follow symlinks

    " let g:rooter_change_directory_for_non_project_files = 'current'
  " }

  " tab completion / snippet engine / snippets:
  Plug 'ervandew/supertab'
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  " Status bar:
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

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
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'kchmck/vim-coffee-script'
  Plug 'elixir-lang/vim-elixir'

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

" Improve performance:
set ttyfast " Defaults to on already with neovim
set regexpengine=1

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

" Show the current command in the bottom right:
set showcmd

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

set number         " show absolute line numbers...
set relativenumber " ...on the current line, and relative numbers elsewhere

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
  set listchars=eol:¬,tab:▸\ ,trail:█,extends:»,precedes:«,space:·
  set list
" }

" Configure UI {
  set t_Co=256
  set background=dark

  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  " Use darker-than-default seoul theme...
  let g:seoul256_background = 233
  colorscheme seoul256

  " ...but don't colour the line number background:
  highlight LineNr       ctermbg=233 guibg=#252525
  highlight CursorLineNr ctermbg=233 guibg=#252525

  highlight StatusLine   ctermfg=15  guifg=#ffffff ctermbg=239 guibg=#4e4e4e cterm=bold gui=bold
  highlight StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none
" }

" Tab completion config {
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }

" Airline config {
  let g:airline_section_x = ''      " Don't care about filetype
  let g:airline_section_y = ''      " Don't care about encoding
  let g:airline_section_z = '%l:%c' " line_no:col_no

  let g:airline_left_sep  = ' '
  let g:airline_right_sep = ' '

  " Git extension config (fugitive) {
    let g:airline#extensions#fugitive#enabled = 1
  " }

  " Tabline extension config {
    let g:airline#extensions#tabline#enabled = 1      " Enable the list of buffers
    let g:airline#extensions#tabline#fnamemod = ':t'  " Show filename, rather than path
    let airline#extensions#tabline#buffer_nr_show = 1 " Show buffer number
  " }
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
