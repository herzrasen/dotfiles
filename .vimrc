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
Plug 'ayu-theme/ayu-vim'
call plug#end()

" set leader key
let mapleader="\<space>"

" diable mouse
set mouse-=a

" how many lines of history to rememer
set history=500

" colors
set termguicolors
let ayucolors="mirage"
colorscheme ayu

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
set updatetime=1000

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

