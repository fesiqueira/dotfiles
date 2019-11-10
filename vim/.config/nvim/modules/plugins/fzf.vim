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
