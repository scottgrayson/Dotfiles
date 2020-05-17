" Plugins {{{
" Managed with vim.plug (maybe use dein in the future)
call plug#begin('~/.vim/plugged')
" ---- Begin Plugin List

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'

" Colorscheme
" Plug 'mhartington/oceanic-next'
" Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'morhetz/gruvbox'
" Plug 'junegunn/seoul256.vim'

" Language
Plug 'jwalton512/vim-blade'
Plug 'vim-scripts/nginx.vim'
" Plug 'wavded/vim-stylus'
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'stanangeloff/php.vim'

" Linting
" Plug 'w0rp/ale'

" Editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'arnaud-lb/vim-php-namespace'

" Github
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Autocomplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" open terminal at current file loc

" ---- End Plugin List
call plug#end()            " required
" }}}

" Misc {{{
let g:AutoPairsFlyMode = 0

" php use statements
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" escape alternatives
inoremap jk <esc>
inoremap kj <esc>

set nocompatible
set visualbell                  " don't beep
set noerrorbells                " don't beep
set autowrite                   " Save on buffer switch
set modelines=1
set title
set hidden

" from coc.nvim example
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes


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

" Gruvbox Terminal colors
" dark0 + gray
let g:terminal_color_0 = "#282828"
let g:terminal_color_8 = "#928374"

" neurtral_red + bright_red
let g:terminal_color_1 = "#cc241d"
let g:terminal_color_9 = "#fb4934"

" neutral_green + bright_green
let g:terminal_color_2 = "#98971a"
let g:terminal_color_10 = "#b8bb26"

" neutral_yellow + bright_yellow
let g:terminal_color_3 = "#d79921"
let g:terminal_color_11 = "#fabd2f"

" neutral_blue + bright_blue
let g:terminal_color_4 = "#458588"
let g:terminal_color_12 = "#83a598"

" neutral_purple + bright_purple
let g:terminal_color_5 = "#b16286"
let g:terminal_color_13 = "#d3869b"

" neutral_aqua + faded_aqua
let g:terminal_color_6 = "#689d6a"
let g:terminal_color_14 = "#8ec07c"

" light4 + light1
let g:terminal_color_7 = "#a89984"
let g:terminal_color_15 = "#ebdbb2"
" }}}
"
" Syntax {{
syntax enable

"hi Comment gui=italic

autocmd FileType vue syntax sync fromstart

au BufRead,BufNewFile */nginx/**/*.conf if &ft == '' | setfiletype nginx | endif

let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
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
if has("gui_macvim")
  set guifont=Fira\ Code:h18
endif

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
" }}}

" Search and Replace {{{
set ignorecase
set smartcase                   " ignore case if search pattern is all lowercase,
nnoremap <CR> :noh<CR>
" }}}

" Plugins {{{
if has("nvim")
" let g:deoplete#enable_at_startup = 1
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:neosnippet#enable_completed_snippet = 1

" Enable snipMate compatibility feature. and vim snippets
" let g:neosnippet#enable_snipmate_compatibility = 1
" let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" s-tab to expand snippet or jump to next field
imap <s-tab>     <Plug>(neosnippet_expand_or_jump)
smap <s-tab>     <Plug>(neosnippet_expand_or_jump)
xmap <s-tab>     <Plug>(neosnippet_expand_target)

" For conceal markers.
set conceallevel=2 concealcursor=niv

" FZF ignore things in gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g "" --ignore ./spark'
" }}}

" Syntax {{{
function! Indent()
  normal! mzgg=G`z
endfunction

" }}}

" Mappings {{{
set timeoutlen=1000 ttimeoutlen=0

" map leader to SPACE
let mapleader=" "

nnoremap <leader>i :call Indent()<CR>
nnoremap <leader>- :%s/\s\+$//e<CR>

"edit vimrc
nnoremap <leader>C :e ~/.vimrc<cr>
nnoremap <leader>% :so ~/.vimrc<cr>

"saving and quitting
cmap Wq<cr> wq<cr>
cmap WQ<cr> wq<cr>
cmap W<cr> w<cr>
cmap Q<cr> q<cr>
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

" skip through linter errors
map <leader>lo :diffg LO<cr>
map <leader>re :diffg RE<cr>
map <leader>ba :diffg BA<cr>

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
"
" Embedded Terminal {{{
" shortcut for split
nnoremap <leader>t :sp term://zsh<cr>i
" escape to normal mode
:tnoremap <c-[> <C-\><C-n>
" }}}

