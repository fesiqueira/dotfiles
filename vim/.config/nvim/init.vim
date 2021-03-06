" start vim-plug
call plug#begin()
    " tools
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  | Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'sheerun/vim-polyglot'
    Plug 'diepm/vim-rest-console'

    " quality of life
    Plug 'tpope/vim-commentary'

    " visual
    Plug 'flazz/vim-colorschemes'
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
    Plug 'junegunn/goyo.vim'

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

filetype plugin indent on
syntax on

" visual
set background=dark
colorscheme hybrid_material
set termguicolors
set t_Co=256
let g:airline_theme = 'angr'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;&lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;&lu;%lu;%lum"
endif

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
set splitright
set splitbelow
set wildmode=list:longest,full
set colorcolumn=120

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
au FileType go nmap <leader><ga> <Plug>(go-alternate-edit)
au FileType go nmap <leader><gt> <Plug>(go-test)
au FileType go nmap <leader><gd> <Plug>(go-doc)

" bindings
noremap <Space> <Nop>
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>o :%bd<BAR>e#<BAR>bd#<CR>\|'"
nnoremap <leader>c :bd<CR>
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>. :Files<CR>
nnoremap <leader>gs :GFiles?<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>* :Rg <C-R><C-W><CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>p :Commands<CR>
nnoremap <leader>rr :source %<CR>
nnoremap <CR> :noh<CR><CR>

" coc configs
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>show_documentation()<CR>
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)


" vim-restconsole configs
let g:vrc_split_request_body = 1

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

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
