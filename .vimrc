" init vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'plasticboy/vim-markdown'
Plug 'mrk21/yaml-vim'
Plug 'cespare/vim-toml'
Plug 'GEverding/vim-hocon'
Plug 'janko/vim-test'
Plug 'neomake/neomake'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'rust-lang/rust.vim'
Plug 'derekwyatt/vim-scala'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" set leader key
let mapleader="\<space>"

" diable mouse
set mouse-=a

" how many lines of history to rememer
set history=500

" colors
set termguicolors
"set t_Co=256
" let ayucolors="mirage"
set background=dark
colorscheme nord

" enable utf-8 as default
set encoding=utf-8

" enable syntax highlighting
syntax on

" enable filetype plugins
filetype plugin on
filetype indent on

" re-read file when changed outside of vim
set autoread

" enable intuitive splitting
set splitbelow
set splitright

" enable wildmenu
set wildmenu

" enable fast saving
nmap <leader>w :w!<cr>

" set 2 lines cursor offset
set so=2

set number relativenumber

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup end

" enable modifications with nerdtree
set modifiable

" show the current position
set ruler

" enable cursorline
set cursorline

" set height of command bar
set cmdheight=3

" better support for diagnostic messages
" set updatetime=1000

" ignore case when searching
set ignorecase

" smart searching
set smartcase

" highlight search results
set hlsearch

" highlight current search result
set incsearch

" show matching brackets when over them
set showmatch

" how many tenth of a second to blink
set mat=5

" disable backups and swapfiles
set nobackup
set nowb
set noswapfile

" spaces as tabs
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" auto indent
set ai

" smart indent
set si

" wrap lines
set wrap

" always show the last status line
set laststatus=2

" permanent undo
set undodir=~/.vim/undo
set undofile

" move a line using alt+[jk]
nnoremap <leader>j mz:m+<cr>`z
nnoremap <leader>k mz:m-2<cr>`z

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

" jump to the end of the line
inoremap <C-e> <C-o>$

" fast reloading of vimrc
au BufWritePost ~/.vimrc source ~/.vimrc

" edit vimrc
map <leader>e :e! ~/.vimrc<cr>

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

au BufRead,BufNewFile todo*     set filetype=todo
au BufRead,BufNewFile *.txt     set filetype=todo
au BufRead *.md set filetype=markdown

""" startify
let g:startify_custom_header = startify#center([])
let g:startify_session_dir = '~/.vim/session'
let g:startify_session_persistence = 1
let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ ]

""" lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

""" nerdtree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 35
nmap <leader>x :NERDTreeToggle<cr>

""" rust
let g:rustfmt_autosave = 1

""" neomake
call neomake#configure#automake('nw', 0)
let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_logfile = '/tmp/neomake.log'
let g:neomake_open_list = 2

""" fzf
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
nnoremap <leader>o :Files<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \    'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \ fzf#vim#with_preview(), <bang>0)
nnoremap <leader>f :Rg<cr>
nnoremap <leader>b :Buffers<cr>

""" coc
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

nnoremap <silent> ,d :<C-u>CocList diagnostics<cr>
nnoremap <silent> ,o :<C-u>CocList outline<cr>

function! Find_cursor_popup(...)
  let radius = get(a:000, 0, 2)
  let srow = screenrow()
  let scol = screencol()

" it's necessary to test entire rect, as some popup might be quite small
  for r in range(srow - radius, srow + radius)
    for c in range(scol - radius, scol + radius)
      let winid = popup_locate(r, c)
      if winid != 0
        return winid
      endif
    endfor
  endfor

  return 0
endfunction

function! Scroll_cursor_popup(down)
  let winid = Find_cursor_popup()
  if winid == 0
    return 0
  endif

  let pp = popup_getpos(winid)
  call popup_setoptions( winid,
        \ {'firstline' : pp.firstline + ( a:down ? 1 : -1 ) } )
  return 1
endfunction

inoremap <silent><expr> <down> Scroll_cursor_popup(1) ? '<esc>' : '<down>'
inoremap <silent><expr> <up> Scroll_cursor_popup(0) ? '<esc>' : '<up>'
nnoremap <expr> <c-d> Scroll_cursor_popup(1) ? '<esc>' : '<c-d>'
nnoremap <expr> <c-u> Scroll_cursor_popup(0) ? '<esc>' : '<c-u>'

" Toggle panel with Tree Views
nnoremap <silent> <leader>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <leader>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <leader>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Reveal current current class (trait or object) in Tree View 'metalsBuild'
nnoremap <silent> <leader>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>

" vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>ta :TestFile<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>ts :TestSuite<CR>
" scala
au BufRead,BufNewFile *.sbt set filetype=scala

" mix-format
let g:mix_format_on_save = 1


