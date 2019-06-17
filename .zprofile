# User specific environment and startup programs

export LIBVIRT_DEFAULT_URI="qemu:///system"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin:$HOME/bin

export GOPATH="$HOME/work/go"
export PATH="$PATH:$GOPATH/bin"

export PAGER="vimpager"

[ -n "$SSH_CONNECTION" ] && unset SSH_ASKPASS
export GIT_ASKPASS=

# /usr/bin/setxkbmap -option "caps:swapescape"
/usr/bin/setxkbmap -option "ctrl:nocaps" && xcape -e 'Control_L=Escape' > /tmp/xcape.log
xmodmap -e "keycode 107 = BackSpace NoSymbol BackSpace"
