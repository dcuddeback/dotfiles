let g:lsp_signs_enabled = 1           " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

if executable('hie')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'hie',
        \ 'cmd': {server_info->['hie', '--lsp']},
        \ 'whitelist': ['haskell'],
        \ })
endif
