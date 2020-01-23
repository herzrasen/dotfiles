" init vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'mhinz/vim-startify'
Plug 'majutsushi/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'mrk21/yaml-vim'
Plug 'neomake/neomake'
Plug 'junegunn/fzf.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'rust-lang/rust.vim' 
Plug 'racer-rust/vim-racer'
Plug 'lifepillar/pgsql.vim'
Plug 'GEverding/vim-hocon'
Plug 'janko/vim-test'
Plug 'dracula/vim'
Plug 'jaredgorski/spacecamp'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
call plug#end()

" disable mouse
set mouse-=a

" how many lines of history to remember
set history=500

" enable 256 colors
set t_Co=256
"colorscheme spacecamp_lite
colorscheme onedark

" enable utf-8 as default
set encoding=utf-8

" enable syntax highlighting
syntax on

"set background=dark

" enable filetype plugins
filetype plugin on
filetype indent on

" re-read a file when changed outside of vim
set autoread

" enable more natural splitting
set splitbelow
set splitright

set wildmenu

" set the map leader
"let mapleader=","
let mapleader="\<space>"

" fast saving
nmap <leader>w :w!<cr>

" set 3 lines cursor offset
set so=3

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" enable modifications with NERDTree
set modifiable

" show the current position
set ruler

" enable cursorline
set cursorline

" height of command bar
set cmdheight=3

" better support for diagnostic messages
set updatetime=1000

" ignore case when searching
set ignorecase

" try smart searching
set smartcase

" highlight search results
set hlsearch

" highlight current search result
set incsearch

" show matching brackets when over them
set showmatch

" how many tenth of a second to blink
set mat=5

" turn off backups and swapfiles
set nobackup
set nowb
set noswapfile

" spaces as tabs
set expandtab

" be smart with tabs
set smarttab

" 4 spaces
set shiftwidth=2
set tabstop=2

" auto indent
set ai

" smart indent
set si

" wrap lines
set wrap

" always show last status line
set laststatus=2

" Permanent undo
set undodir=~/.config/nvim/undo
set undofile

" move a line of text using alt+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" no arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" jump to end of line in insert mode
inoremap <C-e> <C-o>$

" fast reloading of nvim config
map <leader>e :e! ~/.config/nvim/init.vim<cr>
au BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

au BufRead,BufNewFile todo*	set filetype=todo
au BufRead,BufNewFile *.txt	set filetype=todo
au BufRead *.md set filetype=markdown

" startify
let g:startify_custom_header = startify#center([
    \ '____    ____  __  .___  ___.', 
    \ '\   \  /   / |  | |   \/   |', 
    \ ' \   \/   /  |  | |  \  /  |', 
    \ '  \      /   |  | |  |\/|  |', 
    \ '   \    /    |  | |  |  |  |', 
    \ '    \__/     |__| |__|  |__|', 
    \ ]) 

let g:startify_session_dir = '~/.vim/session'
let g:startify_session_persistence = 1
let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },        
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ ]

" lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" ale
" disable highlighting
let g:ale_set_highlights = 0

" run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" auto-pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" gitgutter
let g:gitgutter_log = 1  

" nerdtree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 30
nmap <C-b> :NERDTreeToggle<cr>

" rust
let g:rustfmt_autosave = 1

"" racer
"set hidden
"let g:racer_experimental_completer = 1
"let g:racer_insert_paren = 1
"au FileType rust nmap <leader>d <Plug>(rust-def)
"au FileType rust nmap <leader>h <Plug>(rust-doc)

" neomake
call neomake#configure#automake('nw', 0)
let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_logfile = '/tmp/neomake.log'
let g:neomake_open_list = 2

" fzf
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
nnoremap <leader>o :Files<cr>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nnoremap <leader>f :Rg<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>j :call fzf#vim#tags("'".expand('<cword>'))<cr>
nnoremap <leader>b :Buffers<cr>
" pgsql
let g:sql_type_default = 'pgsql'

" tagbar
nmap <F8> :TagbarToggle<CR>
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

" coc
" don't give ins-completion-menu messages
set shortmess+=c

" always show signcolumns
set signcolumn=yes

set hidden

" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" : 
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-n>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

" Use <C-space> to trigger completion
inoremap <silent><expr> <C-space> coc#refresh()

" Use <cr> to confirm completion, '<C-g>u' means break undo chain at current
" position. 
" Coc only does snippet and additional edit on confirm. 
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-reference)

" formatting
nnoremap <silent> F :call CocAction('format')<CR>

" use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" rename current word
nmap <leader>rn <Plug>(coc-rename)

" float scroll
function! FloatScroll(forward) abort
  let float = coc#util#get_float()
  if !float | return '' | endif
  let buf = nvim_win_get_buf(float)
  let buf_height = nvim_buf_line_count(buf)
  let win_height = nvim_win_get_height(float)
  if buf_height < win_height | return '' | endif
  let pos = nvim_win_get_cursor(float)
  if a:forward
    if pos[0] == 1
      let pos[0] += 3 * win_height / 4
    elseif pos[0] + win_height / 2 + 1 < buf_height
      let pos[0] += win_height / 2 + 1
    else
      let pos[0] = buf_height
    endif
  else
    if pos[0] == buf_height
      let pos[0] -= 3 * win_height / 4
    elseif pos[0] - win_height / 2 + 1  > 1
      let pos[0] -= win_height / 2 + 1
    else
      let pos[0] = 1
    endif
  endif
  call nvim_win_set_cursor(float, pos)
  return ''
endfunction

inoremap <silent><expr> <down> coc#util#has_float() ? FloatScroll(1) : "\<down>"
inoremap <silent><expr>  <up>  coc#util#has_float() ? FloatScroll(0) :  "\<up>"

" vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>ta :TestFile<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>ts :TestSuite<CR>

" mix-format
let g:mix_format_on_save = 1
