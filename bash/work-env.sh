#!bash

source /tools/Xilinx/Vivado/2024.2/settings64.sh
source /tools/Xilinx/Vitis/2024.2/settings64.sh
source $HOME/.cargo/env

alias login-lab="kitty +kitten ssh -Y 192.168.66.53 -l mgrange"

if [ -f /home/mgrange/.arkham-env/arkham-user-environment.sh ]; then
  . /home/mgrange/.arkham-env/arkham-user-environment.sh
fi

