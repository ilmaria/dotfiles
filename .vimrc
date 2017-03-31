"Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'terryma/vim-multiple-cursors'

Plug 'jiangmiao/auto-pairs'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""
"Set global tab size to 2 space
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab


""""""""""""""""""""""""""""""""""""""""""""""
"Cursor blinking
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2


""""""""""""""""""""""""""""""""""""""""""""""
"Show column and row count on status line
set ruler


""""""""""""""""""""""""""""""""""""""""""""""
"Set language specific tab size
autocmd Filetype python setlocal ts=4 sw=4
autocmd Filetype c setlocal ts=4 sw=4


""""""""""""""""""""""""""""""""""""""""""""""
"Make space nop
nnoremap <SPACE> <Nop>

"Map <leader> to space
let mapleader=" "


""""""""""""""""""""""""""""""""""""""""""""""
"Shortcut for saving file
map <leader>w :w<CR>


""""""""""""""""""""""""""""""""""""""""""""""
"Set visual mode background color
"highlight Visual term=reverse cterm=reverse guibg=Grey
"highlight Visual cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40

""""""""""""""""""""""""""""""""""""""""""""""
"Show line numbers
set number


""""""""""""""""""""""""""""""""""""""""""""""
"Show current command at bottom
set showcmd

"Visual autocomplete for command menu
set wildmenu


""""""""""""""""""""""""""""""""""""""""""""""
"Show horizontal line on the cursor position
set cursorline


""""""""""""""""""""""""""""""""""""""""""""""
"Redraw only when needed eg. not during macros
set lazyredraw


""""""""""""""""""""""""""""""""""""""""""""""
"Show matching parenthesis
set showmatch


""""""""""""""""""""""""""""""""""""""""""""""
"Search as characters are typed
set incsearch

"highlight results
set hlsearch


""""""""""""""""""""""""""""""""""""""""""""""
"Update opened file when it has been modified outside of vim
set autoread


""""""""""""""""""""""""""""""""""""""""""""""
"Move to beginning/end of line
nnoremap B ^
nnoremap E $

"$/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>


""""""""""""""""""""""""""""""""""""""""""""""
"Move vertically by visual line
nnoremap j gj
nnoremap k gk
