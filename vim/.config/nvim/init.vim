" start vim-plug
call plug#begin()
    " quality of life
    Plug 'tpope/vim-commentary'

    " visual
    Plug 'flazz/vim-colorschemes'

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

filetype plugin indent on
syntax on


" visual
set background=dark
colorscheme afterglow
set termguicolors
set t_Co=256

set number
set relativenumber
set ruler
set cursorline
set scrolloff=15
set sidescrolloff=15

" f-ing indentation
set expandtab     " turn tabs into spaces
set smarttab      " detect tabs correctly
set tabstop=8     " show tabs as 8 spaces
set shiftwidth=4  " turn tabs into 4 spaces
set softtabstop=4
set autoindent    " copy indent from current line
set wrap

" quality of life
set autoread
set ignorecase
set smartcase
set encoding=utf8
set ttimeout
set ttimeoutlen=100

" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
