" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
"  call plug#begin('~/.local/share/nvim/plugged')

"  Plug 'terryma/vim-multiple-cursors'

"  Plug 'jiangmiao/auto-pairs'

"  call plug#end()

" Syntax highlighting
syntax on

" Indent by filetype
filetype indent plugin on

" Set language specific tab size
autocmd Filetype javascript setlocal ts=2 sw=2
autocmd Filetype html setlocal ts=2 sw=2

" Set global tab size to 4 space
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Enable mouse control in all modes
set mouse=a

" Search down into subfolders
" Provides tab-completion for file-related tasks
set path+=**

" Show column and row count on status line
set ruler

" Make space nop
nnoremap <SPACE> <Nop>

" Map <leader> to space
let mapleader=" "

" Shortcut for saving file
map <leader>w :w<CR>

" Show line numbers
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

" Update opened file when it has been modified outside of vim
set autoread

" Move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Remap some Finnish keyboard keys to match US layout 
nmap å {
nmap ä }
nmap ÅÅ [[
nmap ÄÄ ]]
nmap ö :

" Map <C-space> to autocompletion
imap <C-@> <C-n>
