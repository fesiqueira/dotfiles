set background=light
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
