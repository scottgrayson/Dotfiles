" Plugins {{{
" Managed with vim.plug (maybe use dein in the future)
call plug#begin('~/.vim/plugged')
" ---- Begin Plugin List

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'

" Colorscheme
Plug 'mhartington/oceanic-next'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'posva/vim-vue'

" Linting
Plug 'w0rp/ale'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'AndrewRadev/splitjoin.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Github
Plug 'airblade/vim-gitgutter'

" Autocomplete
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Github
Plug 'tpope/vim-fugitive'

" open terminal at current file loc
Plug 'justinmk/vim-gtfo'

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
set hidden

if has("nvim")
    set inccommand=nosplit
endif
" }}}

" Colors {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
  set termguicolors
endif
set background=dark
"colorscheme OceanicNext
"colorscheme solarized
"colorscheme seoul256
let g:seoul256_background = 235
colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'
" }}}
"
" Syntax {{
syntax enable

hi Comment gui=italic

autocmd FileType vue syntax sync fromstart
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
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=2                " number of spaces to use for autoindenting
autocmd FileType php setlocal shiftwidth=4 softtabstop=4
autocmd FileType blade setlocal shiftwidth=2 softtabstop=2
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set smarttab

set clipboard=unnamed
" }}}

" Tags {{{
set tags=./tags,tags;
" }}}

" Completion {{{
set wildmenu
set wildmode=list:longest,full
set completeopt=longest,menuone

" UltiSnips config
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"
let g:UltiSnipsJumpBackwardTrigger="<alt-tab>"
" }}}

" Search and Replace {{{
set ignorecase
set smartcase                   " ignore case if search pattern is all lowercase,
nnoremap <CR> :noh<CR>
" }}}

" Plugins {{{
let g:deoplete#enable_at_startup = 1
" FZF ignore things in gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" }}}

" Syntax {{{
function! VueIndent()
  normal! gg=VG/importjV/scriptk>,w
endfunction

function! Indent()
  if &filetype == 'vue'
    call VueIndent()
  else
    normal! gg=G
  endif
  normal! :%s/\s\+$//e<CR>
endfunction
" }}}

" Mappings {{{
set timeoutlen=1000 ttimeoutlen=0
let mapleader=","
"
" strip trailing whitespace, retab and reindent
nnoremap <leader>= :call Indent()<CR>

"edit vimrc
nnoremap <leader>C :e ~/.vimrc<cr>
nnoremap <leader>% :so ~/.vimrc<cr>

nnoremap <leader>w :w<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>q :q<CR>
" Search and replace
nnoremap <leader>r :%s/
" buffer prev
nnoremap <leader>p :b#<cr>
" Ag
map <leader>s :Ag 
" FZF
map <leader>g :Commits<cr>
" map <leader>f :GFiles<cr>
map <leader>f :Files<cr>
map <leader>b :Buffers<cr>
map <leader>T :Tags<cr>

" skip through linter errors
map <leader>ln :lnext<cr>
map <leader>lp :lprev<cr>
map <leader>l :ll<cr>

" Colorschemes
map <leader>c :Colors<cr>
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
" }}}

" Backup Directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
" }}}
