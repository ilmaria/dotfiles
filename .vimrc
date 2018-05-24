" Syntax highlighting
syntax on

" Indent by filetype
filetype indent plugin on

" Set language specific tab size
autocmd Filetype javascript setlocal ts=2 sw=2
autocmd Filetype html setlocal ts=2 sw=2
autocmd BufRead,BufNewFile *.nix setlocal ts=2 sw=2

" Set global tab size to 4 space
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Make backspace great again
set backspace=indent,eol,start

" Enable mouse control in all modes
set mouse=a

" Search down into subfolders
" Provides tab-completion for file-related tasks
set path+=**

" Show column and row count on status line
set ruler

" Shortcut f" Show line numbers
set number

" Show relative line numbers
set relativenumber

" Show current command at bottom
set showcmd

" Visual autocomplete for command menu
set wildmenu

" Show horizontal line on the cursor position
set cursorline

" Redraw only when needed eg. not during macros
set lazyredraw

" Show matching parenthesis
set showmatch

" Search as characters are typed
set incsearch

" highlight results
set hlsearch

" Case insensitive search with
set ignorecase

" Update opened file when it has been modified outside of vim
set autoread

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Remap some Finnish keyboard keys to match US layout 
nnoremap å {
nnoremap ä }
nnoremap ÅÅ [[
nnoremap ÄÄ ]]
nnoremap ö :

nnoremap <Space> :
cnoremap <Space><Space> <CR>

" Map <C-space> to autocompletion
imap <C-@> <C-n>

" Map <leader> to space
let mapleader=","

