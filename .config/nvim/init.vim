" We must iMprove things:
set nocompatible

let mapleader = " "

" set default 'runtimepath' (without ~/.vim folders)
let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

" what is the name of the directory containing this file?
let s:portable = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" add the directory to 'runtimepath'
let &runtimepath = printf('%s,%s,%s/after', s:portable, &runtimepath, s:portable)

call plug#begin(printf('%s/plugged', s:portable))
  " colour scheme:
  Plug 'srcery-colors/srcery-vim'

  " { Use FZF for file opening
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    let g:fzf_layout = { 'window': 'enew' }
    let g:fzf_history_dir = '~/.local/share/fzf-history' " Ctrl+n/p for history

    nnoremap <Leader>a :Ag<Space>
    nnoremap <Leader>A :Ag <C-R><C-W><CR>
    nnoremap <Leader>o :Files<CR>
    nnoremap <Leader>O :GFiles<CR>
    nnoremap <Leader>b :Buffers<CR>
  " }

  " { Find in Project
    Plug 'mileszs/ack.vim'

    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif
  " }

  " Preview register contents
  Plug 'junegunn/vim-peekaboo'

  " Easy alignment
  Plug 'junegunn/vim-easy-align'

  " { better autochdir
    Plug 'airblade/vim-rooter'

    let g:rooter_manual_only = 1
    let g:rooter_cd_cmd='lcd'

    nnoremap <silent> <Leader>c :lcd %:p:h<CR>
    nnoremap <silent> <Leader>C :Rooter<CR>
  " }

  " { tab completion / snippet engine / snippets:
    Plug 'ervandew/supertab'
    " let g:SuperTabDefaultCompletionType = 'context'

    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
  " }

  " { Linting
    Plug 'w0rp/ale'

    " Only run linters when modified file is written to disk:
    let g:ale_lint_on_enter        = 0
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_save         = 1

    " For Ruby, only run the RuboCop linter. For JS, use standard.js:
    let g:ale_linters = {
    \  'javascript': ['standard'],
    \  'python': ['pylint'],
    \  'ruby': ['rubocop'],
    \}

    " Run Rubocop in the context of the bundle:
    let g:ale_ruby_rubocop_executable = 'bundle'

    nmap <silent> [r <Plug>(ale_previous_wrap)
    nmap <silent> ]r <Plug>(ale_next_wrap)
    nnoremap <Leader>r :ALEToggle<CR>
  " }

  " { Status / Tab bars:
    Plug 'ap/vim-buftabline'
    let g:buftabline_indicators = 1 " Add '+' to modified buffers in the tabline
  " }

  " Tmux / vim integration:
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'roxma/vim-tmux-clipboard'

  " Better iTerm2 / tmux support:
  Plug 'sjl/vitality.vim'

  " { Workaround block pasting issue on NeoVim (see issue #1822)
    if has('nvim')
      Plug 'bfredl/nvim-miniyank'

      map p <Plug>(miniyank-autoput)
      map P <Plug>(miniyank-autoPut)
    endif
  " }

  " tpope collection:
  if !has('nvim')
    Plug 'tpope/vim-sensible' " let's agree
  endif

  Plug 'joshpencheon/vim-vinegar' " improve netrw (use fork for now)
  Plug 'tpope/vim-endwise'     " do/end magic
  Plug 'tpope/vim-fugitive'    " Git inside vim
  Plug 'tpope/vim-rhubarb'     " GitHub support for fugitive
  Plug 'sodapopcan/vim-twiggy' " Git branch support for fugitive
  Plug 'tpope/vim-repeat'      " better '.' support
  Plug 'tpope/vim-surround'    " brackets etc
  Plug 'tpope/vim-commentary'  " block [un]commenting
  Plug 'tpope/vim-dispatch'    " asynchronous tasks
  Plug 'tpope/vim-unimpaired'  " pairs of mappings

  " { Git signs in the left margin:
    Plug 'airblade/vim-gitgutter'
    set updatetime=250 " the gutter will refresh 'realtime' (250ms)
    let g:gitgutter_max_signs = 2000

    " Use a dot character for all; colours will be different:
    let g:gitgutter_sign_added = '∙'
    let g:gitgutter_sign_modified = '∙'
    let g:gitgutter_sign_removed = '∙'
    let g:gitgutter_sign_modified_removed = '∙'
  " }

  " Git commit browser, :GV / :GV!
  Plug 'junegunn/gv.vim'

  " auto-close brackets etc:
  Plug 'jiangmiao/auto-pairs'

  " { visual select expand/shrink:
    Plug 'terryma/vim-expand-region'

    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)
  " }

  " { physics-based scrolling:
    Plug 'yuttie/comfortable-motion.vim'

    noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(30)<CR>
    noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-30)<CR>
  " }

  " { Python docstring support:
    Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

    let g:pydocstring_formatter = 'google'
  " }

  " Ruby object support:
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'

  " Additional language / env support:
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'kchmck/vim-coffee-script'
  Plug 'elixir-lang/vim-elixir'
  Plug 'vim-ruby/vim-ruby'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'rust-lang/rust.vim'
  Plug 'neovimhaskell/haskell-vim'
  Plug 'OrangeT/vim-csharp'
  Plug 'pearofducks/ansible-vim'
  Plug 'hashivim/vim-terraform'
  Plug 'hashivim/vim-vagrant'
  Plug 'martinda/Jenkinsfile-vim-syntax'
  Plug 'tpope/vim-cucumber'

  Plug 'AndrewRadev/splitjoin.vim' " single / multiline toggles
  Plug 'AndrewRadev/switch.vim'    " switch hash flavours, etc
call plug#end()

set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler " show the cursor position all the time

set nomodeline " disable modelines, e.g. ' ex: ...'

set mouse=a " Enable the mouse everywhere by default

" Basic setup:
syntax on
filetype plugin indent on

if has('vim_starting')
  " even this file needs it...
  set encoding=utf-8
endif

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" Use system (+ selection) clipboard by default:
set clipboard^=unnamed,unnamedplus

" Improve performance:
set ttyfast " Defaults to on already with neovim
set regexpengine=1
set lazyredraw

" No splash screen, use abbreviations,
" truncate if needed, don't give file info
set shortmess=Iat
try
  set shortmess+=F
catch /E539: Illegal character/
endtry

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

set wildmode=longest,list " when tab-completing commands, don't just cycle
set completeopt=longest   " don't show menu for insert mode inc complete

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

" Don't yank as you paste in visual mode:
vnoremap p "_dP

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set scrolloff=2  " Keep cursor 2 lines from boundary when scrolling
set sidescroll=1 " Don't re-center the cursor when scrolling long lines

" searching {
  set nohlsearch " don't highlight all matches
  set incsearch  " realtime highlighting

  if has('nvim')
    set inccommand=split " live :substitute
  endif
" }

" whitespace controls {
  set backspace=indent,eol,start
  set tabstop=2 shiftwidth=2 expandtab
  set nofoldenable " disable code folding
  set nowrap       " don't text-wrap
" }

if has('nvim') " NeoVim terminal:
  tnoremap <ESC> <C-\><C-n>
  tnoremap <Leader><ESC> <C-\><C-n>

  " 100k lines of scrollback in terminal buffer:
  set scrollback=-1

  " autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
  autocmd TermOpen term://* startinsert
endif

" Configure UI {
  if has("patch-7.4.710")
    set listchars=space:⋅,trail:█,tab:▸\ ,extends:»,precedes:«
  else
    set listchars=trail:█,tab:▸\ ,extends:»,precedes:«
  endif
  set list

  set t_Co=256
  set background=dark

  " scheme (don't invert selections)
  let g:srcery_inverse=0
  try
    colorscheme srcery
  catch /E185:/
  endtry

  set fillchars=vert:│ " better than a pipe

  set number     " show absolute line numbers...
  set cursorline " ...and highlight the current one.

  if has('termguicolors')
    set termguicolors
    set noshowmode " Don't show '--INSERT--' etc

    highlight Normal         guibg=black
    highlight LineNr         guibg=black
    highlight CursorLine     guibg=black
    highlight CursorLineNr   guibg=black
    highlight BufTabLineFill guibg=black
    highlight VertSplit      guibg=black guifg=#918175

    highlight Visual guibg=darkgreen

    highlight BufTabLineCurrent guifg=white    guibg=black gui=bold
    highlight BufTabLineActive  guifg=#555555  guibg=black gui=NONE
    highlight BufTabLineHidden  guifg=#333333  guibg=black

    highlight Statusline    guifg=white   guibg=#191919 gui=bold
    highlight StatusLineGit guifg=#98BC37 guibg=#191919 gui=bold
    highlight StatuslineNC  guifg=#555555 guibg=#191919 gui=NONE

    highlight StatusLine_insert  guibg=skyblue   gui=bold guifg=black
    highlight StatusLine_visual  guibg=darkgreen gui=bold
    highlight StatusLine_replace guibg=darkred   gui=bold

    highlight TermCursor   guifg=#BB0000
    highlight TermCursorNC guibg=#550000

    highlight NonText    guifg=#333333
    highlight SpecialKey guifg=#333333

    highlight ALEErrorSign   guifg=#000000 guibg=#FF0000
    highlight ALEWarningSign guifg=#000000 guibg=#FFFF00
    highlight link ALEError   ALEErrorSign
    highlight link ALEWarning ALEWarningSign

    function! MagicStatus(n, focus)
      let mode   = mode()
      let active = winnr() == a:n

      if a:focus == 0
        let group = 'StatusLineNC'
        let git_group = group
      elseif mode == 'i'
        let group     = 'StatusLine_insert'
        let git_group = group
      elseif mode == 'v' || mode == 'V' || mode == "\<C-v>"
        let group = 'StatusLine_visual'
        let git_group = group
      elseif mode == 'r' || mode == 'R'
        let group = 'StatusLine_replace'
        let git_group = group
      elseif active
        let group     = 'StatusLine'
        let git_group = 'StatusLineGit'
      else
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
      autocmd FocusLost                                 * call <SID>RefreshStatuses(0)
      autocmd FocusGained,VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatuses(1)
    augroup END
  endif
  " }

" Strip trailing whitespace, and restore cursor {
  fun! TrimWhitespace()
      let l:save_cursor = getpos('.')
      %s/\s\+$//e
      call setpos('.', l:save_cursor)
  endfun
" }

" Leader maps {
  nnoremap <Leader>w :w<CR>

  " Can anything be learnt from rbgrouleff/bclose.vim to improve this?
  nnoremap <silent> <Leader>q :try\|bp\|bd #\|close\|catch\|endtry<CR>

  nnoremap <silent> <Leader>s :call TrimWhitespace()<CR>
  nnoremap <silent> <Leader>t :term bash -l<CR>
" }
