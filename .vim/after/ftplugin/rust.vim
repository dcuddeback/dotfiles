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
