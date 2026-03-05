#    __                        __                     
#    /\ \                      /\ \                    
#    \ \ \____     __      ____\ \ \___   _ __   ___   
#     \ \ '__`\  /'__`\   /',__\\ \  _ `\/\`'__\/'___\ 
#    __\ \ \L\ \/\ \L\.\_/\__, `\\ \ \ \ \ \ \//\ \__/ 
#   /\_\\ \_,__/\ \__/.\_\/\____/ \ \_\ \_\ \_\\ \____\
#   \/_/ \/___/  \/__/\/_/\/___/   \/_/\/_/\/_/ \/____/
                                        
# If not running interactively, don't do anything:
[[ $- != *i* ]] && return

source "$HOME/.config/bash/.inputrc"
source "$HOME/repos/dotfiles/bash/work-env.sh"

# History Configuration
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%F %T "

# Shell Options:
shopt -s autocd
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Custom Aliases:
alias ..='cd ..'
alias ls='lsd --color=auto --human-readable --group-dirs first'
alias la='lsd --color=auto --human-readable --almost-all --group-dirs first'
alias ll='lsd --color=auto --human-readable --almost-all --long --group-dirs first'
alias lt='lsd --color=auto --human-readable --almost-all --tree --group-dirs first'
alias ld='lsd --color=auto --human-readable --almost-all --tree --group-dirs first --depth'

alias grep='grep --color auto'
alias cls='clear'
alias clr='clear'
alias vim='nvim'
alias tmux-attach='source ~/scripts/tmux-attach.sh'
alias dotfiles-setup='bash ~/repos/dotfiles/scripts/setup.sh'
alias gsu="git submodule update --init --recursive"


# Exports:
export EDITOR="nvim -u ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.lua"
export VISUAL="nvim -u ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.lua"
export HISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/bash/.bash_history"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/bash/.inputrc"

# Less/Man page colors
export LESS_TERMCAP_mb=$'\e[1;36m'    # Begin bold
export LESS_TERMCAP_md=$'\e[1;36m'    # Begin blink
export LESS_TERMCAP_me=$'\e[1;37m'    # End mode
export LESS_TERMCAP_se=$'\e[0m'       # End standout
export LESS_TERMCAP_so=$'\e[01;34m'   # Begin standout
export LESS_TERMCAP_ue=$'\e[0m'       # End underline
export LESS_TERMCAP_us=$'\e[1;4;34m'  # Begin underline

export GCC_COLORS='error=01;31:warning=01;35:note=-1;36:caret=-1;32:locus=01:quote=01'

# Show the current Git branch (no color/escape sequences).
# Outputs " (branch)" or nothing if not in a Git repo.
__ps1_git_branch() {
    local branch
    # Prefer symbolic branch name; fall back to short SHA if detached or no branch
    branch=$(git symbolic-ref --short -q HEAD 2>/dev/null) || branch=$(git rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        printf ' (%s)' "$branch"
    fi
}

# Prompt: user@host [cwd] (branch) on two lines with colors handled in PS1.
export PS1='\n\[\e[0;36m\]┌─[\[\e[0;32m\]\u\[\e[0;36m\]@\[\e[0;32m\]\h\[\e[0;36m\]]\[\e[0m\] \[\e[0;35m\]\w\[\e[0m\]\[\e[0;33m\]$(__ps1_git_branch)\[\e[0m\]\n\[\e[0;36m\]└─>\[\e[0m\] '

if command -v uwsm &>/dev/null && uwsm check may-start && uwsm select; then
    exec systemd-cat -t uwsm_start uwsm start default
fi

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Pretty Boot:
if command -v neofetch &>/dev/null; then
    neofetch
fi
