function! Dot(path)
    return "~/.config/nvim/" . a:path
endfunction

for file in split(glob(Dot("modules/*.vim")), "\n")
    execute "source" file
endfor
