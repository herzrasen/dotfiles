" init vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'neomake/neomake'
Plug 'junegunn/fzf.vim'
" Plug 'jremmen/vim-ripgrep'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'dracula/vim'
call plug#end()

" how many lines of history to remember
set history=500

" enable 256 colors
set t_Co=256
colorscheme dracula

" enable utf-8 as default
set encoding=utf-8

" enable syntax highlighting
syntax on

set background=dark

" enable filetype plugins
filetype plugin on
filetype indent on

" re-read a file when changed outside of vim
set autoread

" set the map leader
"let mapleader=","
let mapleader="\<space>"

" fast saving
nmap <leader>w :w!<cr>

" set 7 lines cursor offset
set so=7

" enable line numbers
set number 

" show the current position
set ruler

" enable cursorline
set cursorline

" height of command bar
set cmdheight=2

" better support for diagnostic messages
set updatetime=300

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
set shiftwidth=4
set tabstop=4

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
" inoremap <left> <nop>
" inoremap <right> <nop>

" fast reloading of nvim config
map <leader>e :e! ~/.config/nvim/init.vim<cr>
au BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

au BufRead,BufNewFile todo*	set filetype=todo
au BufRead,BufNewFile *.txt	set filetype=todo
au BufRead *.md set filetype=markdown

" lightline
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" ale
" disable highlighting
let g:ale_set_highlights = 0

" run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" deoplete
let g:deoplete#enable_at_startup=1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" nerdtree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" rust
let g:rustfmt_autosave = 1

" racer
set hidden
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gx <Plug>(rust-doc)

" neomake
call neomake#configure#automake('nw', 0)
let g:neomake_rust_enabled_makers = ['cargo']

" fzf
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
nnoremap <C-o> :Files<cr>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nnoremap <C-S-f> :Rg<cr>
