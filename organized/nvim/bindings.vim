" Set leader
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast exit
nnoremap <leader><leader>q :q<cr>

" Fast exit without saving
nnoremap <leader><leader><leader> <esc>:q!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
