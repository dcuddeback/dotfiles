set nocompatible          " don't attempt to be compatible with old-style vi

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
set listchars=tab:\ \ ,trail:~,extends:>,precedes:<,nbsp:.

" highlight current line in active window
autocmd WinEnter      * setlocal cursorline
autocmd WinLeave      * setlocal nocursorline
autocmd InsertEnter   * setlocal nocursorline
autocmd InsertLeave   * setlocal cursorline
autocmd CursorHoldI   * setlocal cursorline
autocmd CursorMovedI  * setlocal nocursorline
setlocal cursorline   " enable in active window just after vim loads

" highlight past 80 columns
"highlight OverLength cterm=reverse
"match OverLength /\%81v.*/

" to write to protected files
cmap w!! %!sudo tee %

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
nmap ,tt  :tabnew<CR>
nmap ,tn  :tabn<CR>
nmap ,tN  :tabp<CR>

" copy/cut/paste
vnoremap <C-X> "+x
vnoremap <C-C> "+y
nnoremap <C-V> "+gP
cnoremap <C-V> <C-R>+

" expand surrounding code-folds
nmap zp  zozjzo2zkzozj

" remove trailing white-space when saving a file
autocmd BufWritePre * :%s/\s\+$//e

" Convert words to Ruby symbols
imap <C-k> <Esc>bi:<Esc>Ea
nmap <C-k> lbi:<Esc>E

" Add hash-rocket in Ruby
imap <C-l> <Space>=><Space>
nmap <C-l> i<Space>=><Space><Esc>

" abbreviations
imap habtm  has_and_belongs_to_many
