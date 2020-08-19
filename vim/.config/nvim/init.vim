" start vim-plug
call plug#begin()
    " tools
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  | Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }

    " quality of life
    Plug 'tpope/vim-commentary'

    " visual
    Plug 'flazz/vim-colorschemes'
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

filetype plugin indent on
syntax on

" visual
set background=dark
colorscheme solarized8_dark
set termguicolors
set t_Co=256
" let g:airline_theme = 'angr'
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set number
set relativenumber
set ruler
set cursorline
set scrolloff=15
set sidescrolloff=15
set cmdheight=2
set updatetime=300
set nobackup
set nowritebackup
set hidden

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
set shortmess+=c
autocmd BufWritePre * %s/\s\+$//e " cleanup trailing whitespace

" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" bindings
noremap <Space> <Nop>
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>o :%bd<BAR>e#<CR>
nnoremap <leader>c :bd<CR>
nnoremap <leader><TAB> :bnext<CR>
nnoremap <leader>. :Files<CR>
nnoremap <leader>gs :GFiles?<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>* :Rg <C-R><C-W><CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>p :Commands<CR>
nnoremap <leader>rr :source %<CR>
nnoremap <CR> :noh<CR><CR>

" coc configs
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif
