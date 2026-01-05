#    __                        __                     
#    /\ \                      /\ \                    
#    \ \ \____     __      ____\ \ \___   _ __   ___   
#     \ \ '__`\  /'__`\   /',__\\ \  _ `\/\`'__\/'___\ 
#    __\ \ \L\ \/\ \L\.\_/\__, `\\ \ \ \ \ \ \//\ \__/ 
#   /\_\\ \_,__/\ \__/.\_\/\____/ \ \_\ \_\ \_\\ \____\
#   \/_/ \/___/  \/__/\/_/\/___/   \/_/\/_/\/_/ \/____/
                                        
# If not running interactively, don't do anything:
[[ $- != *i* ]] && return

HISTSIZE=10000

# Custom Aliases:
alias ..='cd ..'
alias ls='lsd --color=auto --human-readable'
alias lsa='lsd --color=auto --human-readable --all'
alias grep='grep --color=auto'
alias cls='clear'
alias clr='clear'
alias vim='nvim'

alias update='sudo pacman -Syyu'
alias grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# Exports:
export EDITOR="nvim -u $HOME/.config/nvim/init.lua"
export VISUAL="nvim -u $HOME/.config/nvim/init.lua"
export HISTFILE="$HOME/.config/bash/.bash_history"
export INPUTRC=/home/mgrange/.config/bash/.inputrc
export GIT_CONFIG_GLOBAL=/home/mgrange/.config/git/gitconfig
export LESS_TERMCAP_mb=$'\e[1;36m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[1;37m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;34m'

# Shell Colors:
export PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\]> '

# Shell Options:
shopt -s autocd

if uwsm check may-start && uwsm select; then 
    exec systemd-cat -t uwsm_start uwsm start default 
fi

# Pretty Boot:
neofetch
