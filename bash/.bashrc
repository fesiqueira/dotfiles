# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
GOPATH="$HOME/work/go/gopath"
PATH="$GOPATH/bin:$PATH"
export GOPATH
export PATH

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash