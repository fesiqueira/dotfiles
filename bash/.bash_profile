# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
function gdoc() {
	go doc $@ | bat -l go
}


. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
