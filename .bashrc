
# Check for an interactive session
[ -z "$PS1" ] && return

#------------------------------------------------
# Set up prompt (taken from Gentoo)
#------------------------------------------------
PS1='[\u@\h \W]\$ '

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

#------------------------------------------------
# Aliases
#------------------------------------------------
alias ls='ls --color=auto'
alias gcal='gcalcli'
alias nano='nano -w'
alias rvim='gvim --remote-silent'
alias pacman='pacman-color'
#------------------------------------------------
# Misc
#------------------------------------------------
eval `dircolors -b` # Set colors for ls
complete -cf sudo   # Auto complete on sudo
complete -cf man    # Auto complete on man
# xmodmap ~/.xmodmap
shopt -s histappend # Append to history
shopt -s checkwinsize # Check window size after every command (prevent wrapping problems)
stty -ixon          # Disable ^S/^Q flow control

# Change the window title of X terminals 
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

#------------------------------------------------
# Environment variables
#------------------------------------------------
export EDITOR="vim"
export HISTCONTROL=ignoredups # Don't add duplicates to history
export HISTSIZE=100000
export HISTFILESIZE=409600
export HISTIGNORE="cd:ls:[bf]g:clear:exit"

#------------------------------------------------
# Paths
#------------------------------------------------
# User scripts and binaries
PATH=$PATH:~/bin

# Android SDK
PATH=$PATH:~/android/android-sdk-linux/platform-tools:~/android/android-sdk-linux/tools:~/android/android-ndk-r5b

export PATH
#------------------------------------------------
