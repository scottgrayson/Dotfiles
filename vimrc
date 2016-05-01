" Plugins {{{
" Managed with vim.plug (maybe use dein in the future)
call plug#begin('~/.vim/plugged')
" ---- Begin Plugin List
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
" ---- End Plugin List
call plug#end()            " required
" }}}
" Misc {{{
set nocompatible
set visualbell                  " don't beep
set noerrorbells                " don't beep
set autowrite                   " Save on buffer switch
set modelines=1
set title
" }}}
" Colors {{{
syntax enable
colorscheme solarized
set background=dark
set t_Co=256
" }}}
" UI settings {{{
set list
set cursorline
set mouse=a
set number                      " always show line numbers
set ruler
set relativenumber
set showmode
set wrap
set scrolloff=3
" }}}
" Fonts {{{
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" }}}
" Windows {{{
set splitbelow
set splitright
" }}}
" Formatting {{{
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set tabstop=4                   " a tab is four spaces
set smarttab
let g:php_cs_fixer_level = "psr2"              " which level ?
" }}}
" Tags {{{
set tags=./tags,tags;
" }}}
" Completion {{{
set wildmenu
set wildmode=list:longest,full
" }}}
" Search and Replace {{{
set ignorecase
set smartcase                   " ignore case if search pattern is all lowercase,
" enter to clear search highlights
nnoremap <CR> :noh<CR>
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
" }}}
" Mappings {{{
set timeoutlen=1000 ttimeoutlen=0
let mapleader=","
nnoremap ,w :w<CR>
" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_
" Ag
map <leader>s :Ag 
" CtrlP
map <leader>f :Files<cr>
map <leader>b :Buffers<cr>
map <leader>t :Tags<cr>
" PHP Beautify
nnoremap <silent><leader>pb :call PhpCsFixerFixFile()<CR>
" Window nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" Backup Directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif
" }}}
" vim:foldmethod=marker:foldlevel=0
