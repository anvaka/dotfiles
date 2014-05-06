set nocompatible               " Be iMproved

set backspace=indent,eol,start

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

set hidden         "allow buffer switching without saving
syntax on          "turn on syntax highlighting
set history=1000   "number of command lines to remember
set list           "highlight whitespace
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮

" Always unfold
set foldlevel=99
set colorcolumn=80
" give me my system clipboard
set clipboard=unnamed

set showcmd
set cursorline

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" Load all plugins
let g:ctrlp_max_files=0
NeoBundle 'matchit.zip'
NeoBundle "dahu/LearnVim"
NeoBundle "aming/vim-mason"
NeoBundle "kien/ctrlp.vim"
NeoBundle "tomasr/molokai"

NeoBundle "scrooloose/nerdtree"
" Open the project tree and expose current file in the nerdtree with Ctrl-\
nnoremap <silent> <C-\> :NERDTreeFind<CR>:vertical res 30<CR>
NeoBundle 'bling/vim-airline' "{{{
  let g:airline_theme = 'powerlineish'
  let g:airline_left_sep = '⧽'
  let g:airline_right_sep = '᚜'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep=' '
  let g:airline#extensions#tabline#left_alt_sep='¦'
"}}}

" repeat.vim: enable repeating supported plugin maps with "."
" http://www.vim.org/scripts/script.php?script_id=2136
NeoBundle "tpope/vim-surround"
NeoBundle "tpope/vim-repeat"
NeoBundle "tpope/vim-dispatch"
NeoBundle "tpope/vim-unimpaired"
NeoBundle "tpope/vim-fugitive"
NeoBundle "jtratner/vim-flavored-markdown"
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END 

NeoBundle "scrooloose/syntastic"
NeoBundle "pangloss/vim-javascript"
NeoBundle "maksimr/vim-jsbeautify"
NeoBundle "Raimondi/delimitMate"
NeoBundle "kana/vim-textobj-user"
NeoBundle "kana/vim-textobj-function"
NeoBundle "kana/vim-textobj-entire"
NeoBundle "kana/vim-textobj-line"
NeoBundle "thinca/vim-textobj-function-javascript"

NeoBundleLazy 'groenewege/vim-less', {'autoload':{'filetypes':['less']}}
NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload':{'filetypes':['css','scss','sass']}}
NeoBundleLazy 'ap/vim-css-color', {'autoload':{'filetypes':['css','scss','sass','less','styl']}}

NeoBundle "Shougo/vimproc.vim"
NeoBundle 'Shougo/unite.vim' "{{{
  let bundle = neobundle#get('unite.vim')
  function! bundle.hooks.on_source(bundle)
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#set_profile('files', 'smartcase', 1)
    call unite#custom#source('line,outline','matchers','matcher_fuzzy')
  endfunction

  let g:unite_data_directory='~/.vim/.cache/unite'
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable=1
  let g:unite_source_rec_max_cache_files=5000
  let g:unite_prompt='» '

  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S'
  let g:unite_source_grep_recursive_opt=''

  function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <esc> <plug>(unite_exit)
  endfunction
  autocmd FileType unite call s:unite_settings()

  nmap <space> [unite]
  nnoremap [unite] <nop>

  nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr><c-u>
  nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr><c-u>
  nnoremap <silent> [unite]e :<C-u>Unite -buffer-name=recent file_mru<cr>
  nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
  nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
  nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
  nnoremap <silent> [unite]/ :<C-u>Unite -auto-preview -no-start-insert -no-quit -buffer-name=search grep:.<cr>
  nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
  nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
  "}}}
  NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources':'file_mru'}}
  NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources':'colorscheme'}} "{{{
    nnoremap <silent> [unite]c :<C-u>Unite -winheight=10 -auto-preview -buffer-name=colorschemes colorscheme<cr>
  "}}}
  NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}} "{{{
    nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>
  "}}}
  NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}} "{{{
    nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
  "}}}
  NeoBundleLazy 'Shougo/unite-help', {'autoload':{'unite_sources':'help'}} "{{{
    nnoremap <silent> [unite]h :<C-u>Unite -auto-resize -buffer-name=help help<cr>
  "}}}
  NeoBundleLazy 'Shougo/junkfile.vim', {'autoload':{'commands':'JunkfileOpen','unite_sources':['junkfile','junkfile/new']}} "{{{
    let g:junkfile#directory=expand("~/.vim/.cache/junk")
    nnoremap <silent> [unite]j :<C-u>Unite -auto-resize -buffer-name=junk junkfile junkfile/new<cr>
  "}}}

NeoBundleLazy 'zhaocai/GoldenView.Vim', {'autoload':{'mappings':['<Plug>ToggleGoldenViewAutoResize']}} "{{{
  let g:goldenview__enable_default_mapping=0
  nmap <F4> <Plug>ToggleGoldenViewAutoResize
"}}}
"NeoBundleLazy 'mattn/emmet-vim', {'autoload':{'filetypes':['html','xml','xsl','xslt','xsd','css','sass','scss','less','mustache']}} "{{{
"  function! s:zen_html_tab()
"    let line = getline('.')
"    if match(line, '<.*>') < 0
"      return "\<c-y>,"
"    endif
"    return "\<c-y>n"
"  endfunction
"  autocmd FileType xml,xsl,xslt,xsd,css,sass,scss,less,mustache imap <buffer><tab> <c-y>,
"  autocmd FileType html imap <buffer><expr><tab> <sid>zen_html_tab()
""}}}

NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neosnippet.vim' "{{{
  let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
  let g:neosnippet#enable_snipmate_compatibility=1

  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
  smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
"}}}
NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7.3.885'} "{{{
  let g:neocomplete#enable_at_startup=1
  let g:neocomplete#data_directory='~/.vim/.cache/neocomplete'
"}}}
NeoBundle "kshenoy/vim-signature"
NeoBundle "rking/ag.vim"
" Run commands quickly. <Leader>r
NeoBundle "thinca/vim-quickrun"

" True Sublime Text style multiple selections for Vim
NeoBundle "terryma/vim-multiple-cursors"

" A Vim plugin which shows a git diff in the gutter (sign column).
NeoBundle "airblade/vim-gitgutter"
NeoBundle 'bufkill.vim'
NeoBundleLazy 'EasyGrep', {'autoload':{'commands':'GrepOptions'}} "{{{
  let g:EasyGrepRecursive=1
  let g:EasyGrepAllOptionsInExplorer=1
  let g:EasyGrepCommand=1
  nnoremap <leader>vo :GrepOptions<cr>
"}}}

let g:syntastic_mode_map = {'mode': 'active','active_filetypes': ['js'], 'passive_filetypes': ['html'] }
let g:syntastic_javascript_checkers = ['jshint']

" Missing fugitive key bindings
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gr :Gremove<CR>

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

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

" ================ Scrolling ========================

set scrolloff=1         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Appearance
set laststatus=2   " Always show the statusline
set t_ut=          " disable backgroun color erase, play nicely with tmux
set t_Co=256       " 256 colors terminal
set number
set ttimeoutlen=50  " Reduce annoying delay for key codes, especially <Esc>..."
colo molokai

" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" endif
" ================ Search Settings  =================

set incsearch       " Find the next match as we type the search
set hlsearch        " Hilight searches by default
set viminfo='100,f1 " Save up to 100 marks, enable capital marks
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital


" My keyboard shortucts:
" Let's make escape better, together.
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>

"make Y consistent with C and D
nnoremap Y y$

" ==============================
" Window/Tab/Split Manipulation
" ==============================
" Move between split windows by using the four directions H, L, I, N
" (note that  I use I and N instead of J and K because  J already does
" line joins and K is mapped to GitGrep the current word
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> <Leader>z :bp<CR>
nnoremap <silent> <Leader>x :bn<CR>

" These are very similar keys. Typing 'a will jump to the line in the current
" file marked with ma. However, `a will jump to the line and column marked
" with ma.  It’s more useful in any case I can imagine, but it’s located way
" off in the corner of the keyboard. The best way to handle this is just to
" swap them: http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Fix mason:
au BufNewFile,BufRead *.m set ft=mason
au BufNewFile,BufRead *.mi set ft=mason

" Installation check.
NeoBundleCheck

nnoremap <unique> <CR> :w<CR>

" Nice YADR functions
" ----- Auto semicolon ---------

" If there isn't one, append a semi colon to the end of the current line.
function! s:appendSemiColon()
  if getline('.') !~ ';$'
    let original_cursor_position = getpos('.')
    exec("s/$/;/")
    call setpos('.', original_cursor_position)
  endif
endfunction

" Use Q to intelligently close a window
" (if there are multiple windows into the same buffer)
" or kill the buffer entirely if it's the last window looking into that buffer
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

" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
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

command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,w :StripTrailingWhitespaces<CR>

" For programming languages using a semi colon at the end of statement.
autocmd FileType c,cpp,css,java,javascript,perl,php,jade,mason nmap <silent> <leader>; :call <SID>appendSemiColon()<CR>
autocmd FileType c,cpp,css,java,javascript,perl,php,jade,mason inoremap <silent> <leader>; <ESC>:call <SID>appendSemiColon()<CR>

" If nerd tree is the last window - quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

autocmd FileType javascript inoremap {<CR> {<CR>}<C-o>O

" toggle paste
map <F6> :set invpaste<CR>:set paste?<CR>
imap <F6> <C-O>:set paste<CR>
  " remap arrow keys
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>
nnoremap <up> :tabnext<CR>
nnoremap <down> :tabprev<CR>

" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
"
" Shamelessly stolen from Gary Bernhardt: https://github.com/garybernhardt/dotfiles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f 3')
  let filenames = split(status, "\n")
  if len(filenames) > 0
    exec "edit " . filenames[0]
    for filename in filenames[1:]
      exec "sp " . filename
    endfor
  end
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

nnoremap <leader>ocf :OpenChangedFiles<CR>

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
