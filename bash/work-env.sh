#!bash

source /tools/Xilinx/Vivado/2024.2/settings64.sh
source /tools/Xilinx/Vitis/2024.2/settings64.sh
source $HOME/.cargo/env

if [ -f /home/mgrange/.arkham-env/arkham-user-environment.sh ]; then
  . /home/mgrange/.arkham-env/arkham-user-environment.sh
fi

alias alert ='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
