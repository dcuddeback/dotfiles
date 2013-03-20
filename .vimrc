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
syntax sync fromstart
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
set mouse=a               " enable mouse in all modes
set updatetime=100        " delay (ms) before CursorHold event

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

" use ; to enter command mode
nnoremap ; :

" reselect visual block after shift
vnoremap < <gv
vnoremap > >gv

" shorter keystrokes for split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" disable those dame arrow keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" to write to protected files
cmap w!! %!sudo tee %

" fix pageup and pagedown behavior
map  <PageUp>   <C-U>
map  <PageDown> <C-D>
imap <PageUp>   <C-O><C-U>
imap <PageDown> <C-O><C-D>

" fix C-Page{Up,Down} in rxvt (sends different key codes)
nmap <ESC>[5^ <C-PageUp>
nmap <ESC>[6^ <C-PageDown>


" Save the last source buffer so that we can return to it after switching to helper windows, such as
" NERDTree or Tagbar.

" Returns true if the current buffer is a source file.
function! g:IsSourceBuffer()
  return !(winnr() == g:NERDTreeWindow() || winnr() == g:TagbarWindow())
endfunction

" Saves the current source buffer so that it can be restored by g:RestoreLastSourceBuffer().
function! g:SaveLastSourceBuffer()
  if g:IsSourceBuffer()
    let t:LastSourceBuffer = bufnr('%')
  endif
endfunction

" Returns to the last source file that was being edited.
function! g:RestoreLastSourceBuffer()
  if exists('t:LastSourceBuffer')
    execute bufwinnr(t:LastSourceBuffer) . 'wincmd w'
  else
    execute 'wincmd p'
  endif
endfunction


" NERDTree
let NERDTreeChDirMode = 2         " keep working directory set to NERD's root node
let NERDTreeWinPos    = "left"
let NERDTreeWinSize   = 35

function! g:NERDTreeWindow()
  if exists('t:NERDTreeBufName')
    return bufwinnr(t:NERDTreeBufName)
  else
    return -1
  endif
endfunction

function! g:OpenNERDTreeWithSaveSourceBuffer()
  call g:SaveLastSourceBuffer()

  if g:NERDTreeWindow() < 0
    NERDTreeToggle
  else
    execute g:NERDTreeWindow() . 'wincmd w'
  endif
endfunction

" Alternates between the NERDTree window and a source window.
function! g:AlternateNERDTreeAndBuffer()
  if winnr() == g:NERDTreeWindow()
    call g:RestoreLastSourceBuffer()
  else
    call g:OpenNERDTreeWithSaveSourceBuffer()
  endif
endfunction

" Focuses the NERDTree window on the current file
function! g:NERDTreeFocusCurrentBuffer()
  if g:NERDTreeWindow() < 0
    call g:OpenNERDTreeWithSaveSourceBuffer()
  endif

  if !g:IsSourceBuffer()
    call g:RestoreLastSourceBuffer()
  endif

  NERDTreeFind
endfunction

noremap  <silent> <F2>      :NERDTreeToggle<CR>
nnoremap <silent> <Leader>f :call g:AlternateNERDTreeAndBuffer()<CR>
nnoremap <silent> <Leader>F :call g:NERDTreeFocusCurrentBuffer()<CR>

" open NERDTree if vim is launched without opening a file
autocmd VimEnter * if !argc() | NERDTree | endif

" quit vim if NERDTree is the only window left open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Tagbar
let g:tagbar_left        = 0
let g:tagbar_width       = 40
let g:tagbar_autofocus   = 1
let g:tagbar_autoclose   = 0
let g:tagbar_sort        = 1
let g:tagbar_compact     = 0
let g:tagbar_expand      = 0
let g:tagbar_singleclick = 1
let g:tagbar_foldlevel   = 4
let g:tagbar_iconchars   = ['▶', '▼']
let g:tagbar_autoshowtag = 1

let g:tagbar_type_coffee = {
      \ 'ctagstype' : 'coffee',
      \ 'kinds' : [
      \   'f:functions',
      \   'v:variables'
      \ ],
      \ }

function! g:TagbarWindow()
  return bufwinnr('__Tagbar__')
endfunction

function! g:OpenTagbarWithSaveSourceBuffer()
  call g:SaveLastSourceBuffer()
  call tagbar#OpenWindow('fj')
endfunction

function! g:AlternateTagbarAndBuffer()
  if winnr() == g:TagbarWindow()
    call g:RestoreLastSourceBuffer()
  else
    call g:OpenTagbarWithSaveSourceBuffer()
  endif
endfunction

noremap  <silent> <F3>      :TagbarToggle<CR>
nnoremap <silent> <Leader>g :call g:AlternateTagbarAndBuffer()<CR>

autocmd VimEnter * nested :call tagbar#autoopen(1)
autocmd FileType * nested :call tagbar#autoopen(0)
autocmd BufEnter * nested :call tagbar#autoopen(0)


" ctags
set tags=./tags;/
map <silent> <C-\>   :vsplit    <CR>:exec("tag ".expand("<cword>"))<CR>
map <silent> <C-S-\> :tab split <CR>:exec("tag ".expand("<cword>"))<CR>

" VimClojure
let vimclojure#FuzzyIndent=1
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun=1

" rainbow_parentheses
"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0

"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

" ri.vim
nnoremap <silent> <Leader>r :call ri#OpenSearchPrompt(1)<CR>
nnoremap <silent> <Leader>R :call ri#OpenSearchPrompt(0)<CR>
nnoremap <silent> <Leader>k :call ri#LookupNameUnderCursor(1)<CR>
nnoremap <silent> <Leader>K :call ri#LookupNameUnderCursor(0)<CR>

autocmd FileType ruby nnoremap <buffer> K :call ri#LookupNameUnderCursor()<CR>

" configure haskellmode-vim
let g:haddock_browser="/usr/bin/chromium-browser"
let $PATH = $PATH . ':' . expand("~/.cabal/bin")

" fix grep in OSX
map <F8> :GrepBuffer<CR><CR>
map <F9> :Rgrep<CR><CR>
let Grep_Find_Use_Xargs = 0

" tabs
nnoremap <silent> <C-PageUp>   :tabprev<CR>
nnoremap <silent> <C-PageDown> :tabnext<CR>

" copy/cut/paste
vnoremap <C-X> "+x
vnoremap <C-C> "+y
nnoremap <C-V> "+gP
cnoremap <C-V> <C-R>+

" expand surrounding code-folds
nmap zp  zozjzo2zkzozj

" remove trailing white-space when saving a file
autocmd BufWritePre * :%s/\s\+$//e

" treat hamlc as haml
autocmd BufRead,BufNewFile *.hamlc set filetype=haml


" debug syntax highlighting
map <Leader>sn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
