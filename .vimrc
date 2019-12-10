" set compatibility to vim only
set nocompatible

" helps force plugins to load correctly, when it is turned back on below
filetype off

" turn on syntax highlighting
syntax on

" for plugins to load correctly
filetype plugin indent on

" turn off modelines
set modelines=0

" automatically wrap text that extends beyond the sceen width
set wrap

" vim's auto indentation does not work properly with text that is copied from
" outside of vim
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O> :set invpaste paste?<CR>
set pastetoggle=<F2>

" show line numbers
set number

" set encoding
set encoding=utf-8

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd
