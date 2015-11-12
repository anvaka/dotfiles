" ==============================
" Sensible vim settings
" ==============================
set nocompatible               " Be iMproved
set autoread                   " Auto reload if file saved externally

set backspace=indent,eol,start

syntax on                      " Turn on syntax highlighting
set hidden                     " Allow buffer switching without saving
set history=1000               " Number of command lines to remember
set list                       " Highlight whitespace
set foldlevel=99               " Always unfold
set colorcolumn=80             " Visual guideline at column 80
set cursorline                 " Highlight current line
set clipboard=unnamed          " give me my system clipboard
set laststatus=0               " Never show the statusline
set t_Co=256                   " 256 colors terminal
set ttimeoutlen=50             " Reduce annoying delay for key codes, especially <Esc>..."
set number                     " Always show line numbers
set showcmd

set shortmess=a

" Turn off beeping
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set encoding=utf-8
if !has('nvim')
  set term=xterm-256color
endif

set t_ut=                      " Disable backgroun color erase, play nicely with tmux
set termencoding=utf-8
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·
set shiftround
set linebreak
let &showbreak='↪ '

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================
set foldmethod=manual   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Search Settings  =================
set incsearch       " Find the next match as we type the search
set hlsearch        " Hilight searches by default
set viminfo='100,f1 " Save up to 100 marks, enable capital marks
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" =============== Basic keyboard shortcuts =============
let mapleader=' '             " Leader key to a comma
let maplocalleader = ' '
nnoremap Y y$                 " Make Y consistent with C and D
nnoremap <unique> <CR> :w<CR> " Save files with Enter key in normal mode

" Move between panes easier
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" Create window splits easier
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Jump between buffers easier
nnoremap <silent> <Leader>z :bp<CR>
nnoremap <silent> <Leader>x :bn<CR>

" Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Escape by smashing jk
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>

" Toggle paste
map <F6> :set invpaste<CR>:set paste?<CR>
imap <F6> <C-O>:set paste<CR>

" Open current file with ,o
nnoremap <Leader>o :!open '%'\<CR>\<CR>

" npm install --save-dev word under cursor
nnoremap <Leader>t :execute ":!npm install --save-dev " . expand("<cword>")<CR>
" npm install --save word under cursor
nnoremap <Leader>s :execute ":!npm install --save " . expand("<cword>")<CR>

" Search and replace the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

nnoremap <silent> <Leader>q :bn \| bd #<CR> " Kill current buffer without closing split

" ================== Install Plguins ============
let s:first_time_launch = 0
if empty(glob("~/.vim/autoload/plug.vim"))
    silent execute '!mkdir -p ~/.vim/autoload'
    silent execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    let s:first_time_launch = 1
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }
  nnoremap <silent> <C-\> :NERDTreeFind<CR>:vertical res 30<CR>
  " If nerd tree is the last window - quit
  autocmd bufenter * if (winnr("$") == 1 && exists('b:NERDTreeType') && b:NERDTreeType == "primary") | q | endif

" Faster large files
Plug 'mhinz/vim-hugefile'
  let g:hugefile_trigger_size=2

Plug 'rking/ag.vim'
Plug 'thinca/vim-quickrun'

" Don't touch sign column
" let g:gitgutter_override_sign_column_highlight = 0
Plug 'airblade/vim-gitgutter' " Show git diff in the gutter

Plug 'tpope/vim-fugitive'
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Glog<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
  set diffopt=vertical " Show always vertical diff

Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'scrooloose/syntastic'
  let g:syntastic_mode_map = {'mode': 'active','active_filetypes': ['js'], 'passive_filetypes': ['html'] }
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0

Plug 'SirVer/ultisnips'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
  Plug 'honza/vim-snippets'
  Plug 'anvaka/snip5'
  let g:ycm_complete_in_comments_and_strings=1
  let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
  let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" ----------------------------------------------------------------------------
" <tab> / <s-tab> / <c-v><tab> | super-duper-tab
" ----------------------------------------------------------------------------
function! s:can_complete(func, prefix)
  if empty(a:func) || call(a:func, [1, '']) < 0
    return 0
  endif
  let result = call(a:func, [0, matchstr(a:prefix, '\k\+$')])
  return !empty(type(result) == type([]) ? result : result.words)
endfunction

function! s:super_duper_tab(k, o)
  if pumvisible()
    return a:k
  endif

  let line = getline('.')
  let col = col('.') - 2
  if line[col] !~ '\k\|[/~.]'
    return a:o
  endif

  let prefix = expand(matchstr(line[0:col], '\S*$'))
  if prefix =~ '^[~/.]'
    return "\<c-x>\<c-f>"
  endif
  if s:can_complete(&omnifunc, prefix)
    return "\<c-x>\<c-o>"
  endif
  if s:can_complete(&completefunc, prefix)
    return "\<c-x>\<c-u>"
  endif
  return a:k
endfunction

if has_key(g:plugs, 'ultisnips')
  " UltiSnips will be loaded only when tab is first pressed in insert mode
  if !exists(':UltiSnipsEdit')
    inoremap <silent> <Plug>(tab) <c-r>=plug#load('ultisnips')?UltiSnips#ExpandSnippet():''<cr>
    imap <tab> <Plug>(tab)
  endif

  let g:SuperTabMappingForward  = "<tab>"
  let g:SuperTabMappingBackward = "<s-tab>"
  function! SuperTab(m)
    return s:super_duper_tab(a:m == 'n' ? "\<c-n>" : "\<c-p>",
                           \ a:m == 'n' ? "\<tab>" : "\<s-tab>")
  endfunction
else
  inoremap <expr> <tab>   <SID>super_duper_tab("\<c-n>", "\<tab>")
  inoremap <expr> <s-tab> <SID>super_duper_tab("\<c-p>", "\<s-tab>")
endif

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  nnoremap <silent> <Leader><Leader> :Files<CR>
  nnoremap <silent> <Leader><Enter>  :Buffers<CR>
  nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
  nnoremap <silent> <Leader>b        :History<CR>

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Javascript goodies
Plug 'millermedeiros/vim-esformatter', {'for': ['javascript', 'html', 'css']}
" Plug 'maksimr/vim-jsbeautify', {'for': ['javascript', 'html', 'css']}
"   Plug 'einars/js-beautify', {'for': ['javascript', 'html', 'css']}
nnoremap <silent> <c-f> :Esformatter<CR>
vnoremap <silent> <c-f> :EsformatterVisual<CR>
  " autocmd FileType javascript nmap <buffer> <c-f> :call JsBeautify()<cr>
  " autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  " autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

Plug 'moll/vim-node', {'for': ['javascript']}
  autocmd FileType javascript map <buffer> gf <Plug>NodeGotoFile

Plug 'mattn/emmet-vim', { 'for': 'html' }

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'marijnh/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
  let g:tern_show_signature_in_pum = 1
  let g:tern_show_argument_hints = 'on_hold'
  set completeopt-=preview
  autocmd FileType javascript map <buffer> gd :TernDef<CR>

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-entire'
Plug 'thinca/vim-textobj-function-javascript', { 'for': 'javascript' }
Plug 'aming/vim-mason', { 'for': 'mason' }
  au BufNewFile,BufRead *.m set ft=mason
  au BufNewFile,BufRead *.mi set ft=mason

Plug 'altercation/vim-colors-solarized'
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'briancollins/vim-jst'

filetype plugin indent on
call plug#end()

if s:first_time_launch
  PlugInstall
endif

" Now that we have plugins loaded, initialize their settings:
try
  let g:solarized_termcolors=256
  set background=dark
  colorscheme solarized
  hi! Visual ctermfg=White ctermbg=125 term=none cterm=none

  highlight SignColumn ctermbg=234
  highlight LineNr ctermbg=234
  highlight LineNr ctermfg=235
  highlight NonText ctermfg=235
catch
  " Probably running for the first time. Need to run PlugInstall
endtry

" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command! -nargs=1 S
      \ | execute ':silent !git checkout '.<q-args>
      \ | execute ':redraw!'

command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap <Leader>w :StripTrailingWhitespaces<CR>

" Use Q to intelligently close a window
function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  " We should never bdelete a nerd tree
  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction

nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>
