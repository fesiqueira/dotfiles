" Plugins
call plug#begin()
	" Plug 'Shougo/deoplete.nvim', { 'commit': 'edbc7b721e45f1eaa9e1ebe695f4f363f14a7a67' }
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'danilo-augusto/vim-afterglow'
	Plug 'icymind/NeoSolarized'
	Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
	Plug 'easymotion/vim-easymotion'
	Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-commentary'
	Plug 'diepm/vim-rest-console'
	Plug 'jiangmiao/auto-pairs'
	Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
	Plug 'flazz/vim-colorschemes'

	" Go"
	Plug 'fatih/vim-go'
call plug#end()

" General settings
colorscheme afterglow
set background=dark
set termguicolors
set t_Co=256
set encoding=UTF-8
set updatetime=1000
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoread
set so=15
set hlsearch
set wrap
set number
set relativenumber
set cursorline
set splitbelow
set splitright
set wildmenu
set wildmode=list:longest,full

autocmd BufWritePre * %s/\s\+$//e

" Mappings
"
noremap <Space> <Nop>
let mapleader = " "
nnoremap <leader>fs :w<cr>
nnoremap <leader>ee :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>. :lcd %:p:h<CR>
" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
nnoremap <leader>o :only<CR>
nnoremap <leader>q :bprevious<CR>
nnoremap <leader>w :bnext<CR>
nnoremap <leader>c :bdelete<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Use K to show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <leader>e :FZF -m<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>fm :Maps<CR>
nnoremap <leader>ft :Filetypes<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>* :Rg <C-R><C-W><CR>

" use ripgrep
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

let g:airline_theme = 'angr'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
map <leader>j <plug>(easymotion-prefix)
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
