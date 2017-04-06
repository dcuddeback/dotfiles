setlocal foldlevel=0

let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types',
        \'f:functions',
        \'g:enums',
        \'s:structs',
        \'m:modules',
        \'c:consts',
        \'t:traits',
        \'i:impls',
    \]
\}

compiler cargo

" Disable Syntastic because it uses rustc on the filename, which reports false errors because it's
" not considering the file's context within a project.
let g:syntastic_rust_checkers = []
