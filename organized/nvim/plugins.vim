if empty(glob('~/.config/nvim/autoload/plug.vim'))
  if !executable("curl")
    echoerr 'Please install cURL before proceding.'
    execute "q!"
  endif

  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(expand('~/.config/nvim/plugged'))

  Plug 'danilo-augusto/vim-afterglow'

  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  Plug 'ludovicchabant/vim-gutentags'
call plug#end()
