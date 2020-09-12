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

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " ${BRANCH}${STAT}"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " [${bits}] "
	else
		echo ""
	fi
}

export PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXIT="$?"

    local RCol='\[\e[m\]'
    local LRed='\[\e[38;5;161m\]'
    local LBlue='\[\e[38;5;105m\]'
    local LGreen='\[\e[38;5;113m\]'
    local LYellow='\[\e[38;5;221m\]'
    local LOrange='\[\e[38;5;209m\]'
    local DGray='\[\e[38;5;240m\]'

    local GIT_STATUS=`parse_git_branch`

    # 24h clock with seconds and path to current directory
    PS1="${DGray}\t${RCol} ${LRed}\w${RCol} "

    [[ $GIT_STATUS != "" ]] && PS1+="on ${LBlue}${GIT_STATUS}${RCol}"

    [ $EXIT -ne 0 ] && PS1+=" \n ${LOrange}\$${RCol} " || PS1+=" \n ${LGreen}\$${RCol} "
}

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export EDITOR=nvim
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
