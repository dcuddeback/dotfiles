setlocal listchars=tab:\ \ ,trail:~,extends:>,precedes:<,nbsp:.
setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal foldmethod=syntax
setlocal foldlevel=0

" Requires goimports [https://godoc.org/code.google.com/p/go.tools/cmd/goimports]
"   go get code.google.com/p/go.tools/cmd/goimports
let g:gofmt_command="goimports"

" Requires gotags [https://github.com/jstemmer/gotags].
"   go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

autocmd WinEnter *.go :Fmt
autocmd WinLeave *.go :Fmt

" preserves code folds after running gofmt
autocmd BufWritePre *.go execute "normal! mz:mkview\<esc>:Fmt\<esc>:loadview\<esc>`z"
