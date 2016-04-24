" Plugins {{{
" Managed with vundle (maybe use dein in the future)
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Begin Plugin List
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'flazz/vim-colorschemes'
Plugin 'airblade/vim-gitgutter'
" End Plugin List
call vundle#end()            " required
filetype plugin indent on    " required
" }}}
"
" Misc {{{
set nocompatible
set tags=tags
set visualbell                  " don't beep
set noerrorbells                " don't beep
set autowrite                   " Save on buffer switch
set modelines=1
" }}}

" Colors {{{
syntax enable
colorscheme jellybeans
" set background=dark
set t_Co=256
" }}}

" UI Settings {{{
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
set cursorline
set mouse=a
set number                      " always show line numbers
set ruler
" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif
set showmode
set nowrap
set scrolloff=3
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
" }}}

" Completion {{{
set wildmenu
set wildmode=list:longest,full
" }}}

" Search and Replace {{{
set gdefault                    " add global flag to search and replace
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
" enter to clear search highlights
nnoremap <CR> :noh<CR><CR>
" }}}

" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
" }}}

" Mappings {{{
set timeout timeoutlen=200 ttimeoutlen=100
let mapleader=","
" }}}

" Backup Directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
