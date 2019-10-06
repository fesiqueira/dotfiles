if empty($vim_path)
    let $vim_path ='~/.config/nvim'
endif

""" Plugins Management
if filereadable(expand($vim_path . '/plugins.vim'))
    source  $vim_path/plugins.vim
end

""" General settings
if filereadable(expand($vim_path . '/general.vim'))
    source $vim_path/general.vim
end

""" Bindings settings
if filereadable(expand($vim_path . '/bindings.vim'))
    source $vim_path/bindings.vim
end

""" Visual stuff
if filereadable(expand($vim_path . '/visual.vim'))
    source $vim_path/visual.vim
end
