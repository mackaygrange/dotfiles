#    __                        __                     
#    /\ \                      /\ \                    
#    \ \ \____     __      ____\ \ \___   _ __   ___   
#     \ \ '__`\  /'__`\   /',__\\ \  _ `\/\`'__\/'___\ 
#    __\ \ \L\ \/\ \L\.\_/\__, `\\ \ \ \ \ \ \//\ \__/ 
#   /\_\\ \_,__/\ \__/.\_\/\____/ \ \_\ \_\ \_\\ \____\
#   \/_/ \/___/  \/__/\/_/\/___/   \/_/\/_/\/_/ \/____/
                                        
# If not running interactively, don't do anything:
[[ $- != *i* ]] && return

# History Configuration
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%F %T "

# Custom Aliases:
alias ..='cd ..'
alias ls='lsd --color=auto --human-readable --group-directories-first --sort=name'
alias la='lsd --color=auto --human-readable --almost-all --group-directories-first --sort=name'
alias ll='lsd --color=auto --human-readable --almost-all --long --group-directories-first --sort=name'
alias lt='lsd --color=auto --human-readable --almost-all --tree --group-directories-first --sort=name'
alias grep='grep --color=auto'
alias cls='clear'
alias clr='clear'
alias vim='nvim'
alias grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias dotfiles-setup='bash ~/repos/dotfiles/setup.sh'

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

# Shell Colors:
# Simple PS1:
# export PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\]> '

# Fancy PS1 with user-dependent prompt symbol and Git branch info (if available)
# Color codes: 36m=cyan, 32m=green, 35m=magenta, 33m=yellow, 31m=red, 0m=reset
__ps1_git_branch() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        echo " \[\e[0;33m\]($branch)\[\e[0m\]"
    fi
}

export PS1='\n\[\e[0;36m\]┌─[\[\e[0;32m\]\u\[\e[0;36m\]@\[\e[0;32m\]\h\[\e[0;36m\]]\[\e[0m\] \[\e[0;35m\]\w\[\e[0m\]$(__ps1_git_branch)\n\[\e[0;36m\]└─>\[\e[0m\] '

# Shell Options:
shopt -s autocd
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

if command -v uwsm &>/dev/null && uwsm check may-start && uwsm select; then
    exec systemd-cat -t uwsm_start uwsm start default
fi

# Pretty Boot:
if command -v neofetch &>/dev/null; then
    neofetch
fi
