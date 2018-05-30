" Which command to run to get psql. Should be simply `psql` for most.
let g:vipsql_psql_cmd = "psql"

" The prompt to show when running `:VipsqlShell`
let g:vipsql_shell_prompt = "> "

" What `vim` command to use when opening the scratch buffer
let g:vipsql_new_buffer_cmd = "rightbelow split"

" Commands executed after opening the scratch buffer
" Chain multiple commands together with `|` like so:
" "setlocal buftype=nofile | setlocal nowrap"
let g:vipsql_new_buffer_config = 'setlocal buftype=nofile'

" Whether or not the vipsql-buffer should automatically scroll to the bottom
" on new input.
let g:vipsql_auto_scroll_enabled = 1

" Whether or not to print a separator in the output buffer when sending a new
" command/query to psql.
let g:vipsql_separator_enabled = 0

" What that separator should look like.
let g:vipsql_separator = '────────────────────'

" Starts an async psql job, prompting for the psql arguments.
" Also opens a scratch buffer where output from psql is directed.
noremap <leader>po :VipsqlOpenSession<CR>

" Terminates psql (happens automatically if the scratch buffer is closed).
noremap <silent> <leader>pk :VipsqlCloseSession<CR>

" In normal-mode, prompts for input to psql directly.
nnoremap <leader>ps :VipsqlShell<CR>

" In visual-mode, sends the selected text to psql.
vnoremap <leader>ps :VipsqlSendSelection<CR>

" Sends the selected _range_ to psql.
noremap <leader>pr :VipsqlSendRange<CR>

" Sends the current line to psql.
noremap <leader>pl :VipsqlSendCurrentLine<CR>

" Sends the entire current buffer to psql.
noremap <leader>pb :VipsqlSendBuffer<CR>

" Sends `SIGINT` (C-c) to the psql process.
noremap <leader>pc :VipsqlSendInterrupt<CR>
