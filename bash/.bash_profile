# .bash_profile

# set umask for WSL if umask is 0000
grep -q "Microsoft" /proc/version && [[ "$(umask)" == "0000" ]] && umask 022

# if [ "$(umask)" == "0000" ]; then
# 	umask 022
# fi

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
