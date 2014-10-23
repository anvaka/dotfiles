set nocompatible               " Be iMproved
set autoread                   " auto reload if file saved externally

set backspace=indent,eol,start

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif



set hidden         "allow buffer switching without saving
syntax on          "turn on syntax highlighting

autocmd BufReadPre * if getfsize(expand("%")) > 5000000 | call s:setLargFile() | endif

function! s:setLargFile()
  syntax off
endfunction

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

call neobundle#begin(expand('~/.vim/bundle'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'matchit.zip'
NeoBundle "dahu/LearnVim"
NeoBundle "aming/vim-mason"
NeoBundle "ctrlpvim/ctrlp.vim"
NeoBundle "tomasr/molokai"
NeoBundle "altercation/vim-colors-solarized"
NeoBundle "tomtom/tcomment_vim"
NeoBundle "scrooloose/nerdtree"

" repeat.vim: enable repeating supported plugin maps with "."
" http://www.vim.org/scripts/script.php?script_id=2136
NeoBundle "tpope/vim-surround"
NeoBundle "tpope/vim-repeat"
NeoBundle "tpope/vim-dispatch"
NeoBundle "tpope/vim-unimpaired"
NeoBundle "tpope/vim-fugitive"
NeoBundle "jtratner/vim-flavored-markdown"

NeoBundle 'bling/vim-airline'
  let g:airline_theme = 'solarized'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#left_sep=' '
  let g:airline#extensions#tabline#left_alt_sep='¦'
  let g:airline#extensions#tabline#buffer_nr_show = 1

NeoBundleLazy 'marijnh/tern_for_vim', {
    \ 'autoload': { 'filetypes': ['javascript'] },
    \ 'build': {
      \ 'mac': 'npm install',
      \ 'unix': 'npm install',
      \ 'cygwin': 'npm install',
      \ 'windows': 'npm install',
    \ },
  \ }

NeoBundle "scrooloose/syntastic"
NeoBundle "pangloss/vim-javascript"
NeoBundle "Raimondi/delimitMate"
NeoBundle "kana/vim-textobj-user"
NeoBundle "kana/vim-textobj-function"
NeoBundle "kana/vim-textobj-entire"
NeoBundle "kana/vim-textobj-line"
NeoBundle "thinca/vim-textobj-function-javascript"
NeoBundle "moll/vim-node"
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'einars/js-beautify'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundleLazy 'groenewege/vim-less', {'autoload':{'filetypes':['less']}}
NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload':{'filetypes':['css','scss','sass']}}
NeoBundleLazy 'ap/vim-css-color', {'autoload':{'filetypes':['css','scss','sass','less','styl']}}
NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources':'file_mru'}}

NeoBundle "othree/html5.vim"

NeoBundleLazy 'mattn/emmet-vim', {'autoload':{'filetypes':['html','xml','xsl','xslt','xsd','css','sass','scss','less','mustache']}} "{{{
  " autocmd FileType html,xml,xsl,xslt,xsd,css,sass,scss,less,mustache imap <expr><tab> neosnippet#expandable_or_jumpable() ?
  "    \ "\<Plug>(neosnippet_expand_or_jump)"
  "    \: "<c-y>,"
"}}}

NeoBundle 'nelstrom/vim-visual-star-search'
NeoBundle 'anvaka/snip5'
NeoBundle 'anvaka/vim-define-key'
NeoBundle 'anvaka/vim-cmd-bundle'

NeoBundle 'Shougo/neosnippet.vim' "{{{
  let g:neosnippet#disable_runtime_snippets = {
  \   '_' : 1,
  \ }
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

  " Enable snipMate compatibility feature.
  let g:neosnippet#snippets_directory='~/.vim/bundle/snip5/snippets'
  let g:neosnippet#enable_snipmate_compatibility=1
  " SuperTab like snippets' behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
   \ "\<Plug>(neosnippet_expand_or_jump)"
   \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
   \ "\<Plug>(neosnippet_expand_or_jump)"
   \: "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
"}}}

NeoBundle 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7.3.885'} "{{{
  let g:neocomplete#enable_at_startup=1
  let g:neocomplete#data_directory='~/.vim/.cache/neocomplete'
"}}}

NeoBundle 'Shougo/context_filetype.vim'

NeoBundle "kshenoy/vim-signature"
NeoBundle "rking/ag.vim"
" Run commands quickly. <Leader>r
NeoBundle "thinca/vim-quickrun"

" A Vim plugin which shows a git diff in the gutter (sign column).
NeoBundle "airblade/vim-gitgutter"
NeoBundle 'bufkill.vim'

call neobundle#end()

let g:ctrlp_max_files=0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

" Open the project tree and expose current file in the nerdtree with Ctrl-\
nnoremap <silent> <C-\> :NERDTreeFind<CR>:vertical res 30<CR>

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END


let g:tern_show_signature_in_pum = 1
set completeopt-=preview

call unite#custom#source('file,file/new,buffer,file_rec,file_mru,menu', 'matchers', 'matcher_fuzzy')
call unite#custom#source('menu', 'sorters', 'sorter_reverse')
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('files', 'filters', 'sorter_rank')
" Call unite#custom#profile('default', 'context', {
"               \ 'start_insert': 1,
"               \ 'direction': 'botright',
"               \ })

let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
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

nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:! buffer file_mru<cr><c-u>
nnoremap <silent> [unite]e :<C-u>Unite -buffer-name=recent file_mru<cr>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -auto-preview -no-start-insert -no-quit -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>

nmap <Space>p :Unite menu:palette<CR>

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
set t_Co=256       " 256 colors terminal

set encoding=utf-8
set term=xterm-256color
set t_ut=          " disable backgroun color erase, play nicely with tmux
set termencoding=utf-8
set number
set ttimeoutlen=50  " Reduce annoying delay for key codes, especially <Esc>..."

let g:solarized_termcolors=256
set background=dark
colorscheme solarized
hi! Visual ctermfg=White ctermbg=125 term=none cterm=none

" ================ Search Settings  =================

set incsearch       " Find the next match as we type the search
set hlsearch        " Hilight searches by default
set viminfo='100,f1 " Save up to 100 marks, enable capital marks
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set diffopt+=vertical " i love vertical diffs

" My keyboard shortucts:
" Let's make escape better, together.
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
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

" Kill current buffer without closing split
nnoremap <silent> ,q :bn \| bd #<CR>

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

autocmd FileType javascript map <buffer> gf <Plug>NodeGotoFile
autocmd FileType javascript map <buffer> gd :TernDef<CR>
autocmd FileType javascript map <buffer> tr :TernRename<CR>
" For programming languages using a semi colon at the end of statement.
autocmd FileType javascript nmap <buffer> <c-f> :call JsBeautify()<cr>

autocmd FileType javascript inoremap {<CR> {<CR>}<C-o>O

" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" If nerd tree is the last window - quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

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

function! ExtractJSFunction()
 exe "normal! \"myiwo\<CR>function \<C-R>\m() {\<CR>}\<ESC>O"
endfunction
command! ExtractJSFunction :call ExtractJSFunction()
nnoremap <C-X>f :ExtractJSFunction<CR>

function! Slide(num)
  call system('git checkout -- .')
  call system('git checkout slide'.a:num)
  exec "e!"
endfunction

call cmd#define('Quit without checking for changes (same as ":q!")', "ZQ", "}}")
call cmd#define('Search and replace the word under the cursor', ':%s/\<<C-r><C-w>\>/', "<Leader>s")
call cmd#define('Edit file under cursor', ':edit <cfile><cr>', "<Leader>gf")
call cmd#define('Open current file with system app', ':!open "%"<CR><CR>', "<Leader>o")
call cmd#define('Preferences: Key Bindings', ':redir @z<CR>:silent verbose map<CR>:enew<CR>"zp')
call cmd#define('Preferences: Commands', ':redir @z<CR>:silent verbose command<CR>:enew<CR>"zp')

call cmdbundle#load()

function! s:defineSyntax(language)
  call cmd#define('Set Syntax: ' . a:language, ":set ft=" . tolower(a:language) . '<CR>')
  return ''
endfunction

let s:languages = ['HTML', 'JavaScript', 'Vim', 'none']
let s:result = map(s:languages, 's:defineSyntax(v:val)')
