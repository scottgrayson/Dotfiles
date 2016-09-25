" Plugins {{{
" Managed with vim.plug (maybe use dein in the future)
call plug#begin('~/.vim/plugged')
" ---- Begin Plugin List
" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Syntax
Plug 'altercation/vim-colors-solarized'
Plug 'sheerun/vim-polyglot'
Plug 'posva/vim-vue'
" Editing
Plug 'tpope/vim-surround'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Github
Plug 'airblade/vim-gitgutter'
" Autocomplete
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" Github
Plug 'tpope/vim-fugitive'
"markdown
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
"
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
set expandtab                   " expand tabs by default (overloadable per file type later)
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4                " number of spaces to use for autoindenting
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set smarttab
let g:php_cs_fixer_level = "psr2"              " which level ?

set clipboard=unnamed
" }}}
" Tags {{{
set tags=./tags,tags;
" }}}
" Completion {{{
set wildmenu
set wildmode=list:longest,full
" deoplete config
let g:deoplete#enable_at_startup = 1
" UltiSnips config
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-Del>"
" }}}
" {{{ Filtype Settings (Blade, Vue, etc)
" associate *.blade.php and Vue with html filetype
" au BufRead,BufNewFile *.vue set filetype=html
" }}}
" Search and Replace {{{
set ignorecase
set smartcase                   " ignore case if search pattern is all lowercase,
" enter to clear search highlights
nnoremap <CR> :noh<CR>
" FZF ignore things in gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
" }}}
" Mappings {{{
set timeoutlen=1000 ttimeoutlen=0
let mapleader=","
" strip trailing whitespace, retab and reindent
nnoremap <leader><tab> :%s/\s\+$//e<cr>gg=<S-G><cr>

nnoremap <leader>w :w<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>q :wq<CR>
" Search and replace
nnoremap <leader>r :%s/
" buffer prev
nnoremap <leader>p :b#<cr>
" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_
" Ag
map <leader>s :Ag 
" FZF
map <leader>f :Files<cr>
map <leader>b :Buffers<cr>
map <leader>t :Tags<cr>
" PHP Beautify
" nnoremap <silent><leader>pb :call PhpCsFixerFixFile()<CR>
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
" vim:foldmethod=marker:foldlevel=1
