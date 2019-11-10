let mapleader = ","

nnoremap <leader>, :w<cr>
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
