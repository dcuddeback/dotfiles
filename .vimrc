set nocompatible          " don't attempt to be compatible with old-style vi

" NOTE: The following CamelCaseMotion definitions must be done before sourcing the plugin, according
" the the plugin's README.

" define CamelCastMotion motion commands
map mw <Plug>CamelCaseMotion_w
map mb <Plug>CamelCaseMotion_b
map me <Plug>CamelCaseMotion_e

" define CamelCaseMotion text objects
omap imw <Plug>CamelCaseMotion_iw
xmap imw <Plug>CamelCaseMotion_iw
omap imb <Plug>CamelCaseMotion_ib
xmap imb <Plug>CamelCaseMotion_ib
omap ime <Plug>CamelCaseMotion_ie
xmap imb <Plug>CamelCaseMotion_ib

call pathogen#infect()

behave xterm
syntax on
colorscheme jellybeans
filetype plugin indent on

" editor behavior
set wildmenu              " show matches on tab-completion
set incsearch             " show matches while typing search string
set noshowmatch           " don't jump to matching bracket after typing closing bracket
set foldmethod=marker     " avoid slowness of foldmethod=syntax
set foldlevel=3
set nostartofline         " keep cursor in same column during motion commands
set modeline              " read modelines

" indentation preferences
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set autoindent
set textwidth=100

" C formatting options
set cinoptions=t0,+2s,g0
set cinwords=if,unless,else,while,until,do,for,switch,case
set cindent
set formatoptions=croql

" display options
set number                " show line numbers
set ruler                 " show current line, column, and relative position in file
set showmode              " show current mode (insert, replace, visual)
set nowrap                " don't wrap long lines
set novisualbell          " no blinking
set noerrorbells          " no noise
set list                  " show hidden characters
set listchars=tab:>=,trail:~,extends:>,precedes:<,nbsp:.

" highlight current line in active window
autocmd WinEnter      * setlocal cursorline
autocmd WinLeave      * setlocal nocursorline
autocmd InsertEnter   * setlocal nocursorline
autocmd InsertLeave   * setlocal cursorline
autocmd CursorHoldI   * setlocal cursorline
autocmd CursorMovedI  * setlocal nocursorline
setlocal cursorline   " enable in active window just after vim loads

let mapleader = ","

" highlight past 80 columns
"highlight OverLength cterm=reverse
"match OverLength /\%81v.*/

" to write to protected files
cmap w!! %!sudo tee %

map  <PageUp>   <C-U>
map  <PageDown> <C-D>
imap <PageUp>   <C-O><C-U>
imap <PageDown> <C-O><C-D>

" fix C-Page{Up,Down} in rxvt (sends different key codes)
nmap <ESC>[5^ <C-PageUp>
nmap <ESC>[6^ <C-PageDown>

" NERDTree
map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode = 2         " keep working directory set to NERD's root node
let NERDTreeWinPos    = "right"
let NERDTreeWinSize   = 35

" taglist
map <F3> :TlistToggle<CR>
let Tlist_WinWidth                = 45
let Tlist_Show_Menu               = 1
let Tlist_Auto_Open               = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close    = 1

" fix grep in OSX
map <F8> :GrepBuffer<CR><CR>
map <F9> :Rgrep<CR><CR>
let Grep_Find_Use_Xargs = 0

" quickfix
nmap ,en  :cnext<CR>
nmap ,eN  :cprevious<CR>

" tabs
noremap <C-PageUp>   :tabprev<CR>
noremap <C-PageDown> :tabnext<CR>

" copy/cut/paste
vnoremap <C-X> "+x
vnoremap <C-C> "+y
nnoremap <C-V> "+gP
cnoremap <C-V> <C-R>+

" expand surrounding code-folds
nmap zp  zozjzo2zkzozj

" remove trailing white-space when saving a file
autocmd BufWritePre * :%s/\s\+$//e
