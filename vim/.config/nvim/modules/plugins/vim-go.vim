let g:go_fmt_command = "goimports"
let g:go_info_mode = "gopls"
let g:go_auto_type_info = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" let g:go_auto_sameids = 1

au FileType go nmap <leader>ga <Plug>(go-alternate-edit)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gc <Plug>(go-doc)
