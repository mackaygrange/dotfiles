#!bash

source /tools/Xilinx/Vivado/2024.2/settings64.sh
source /tools/Xilinx/Vitis/2024.2/settings64.sh
source $HOME/.cargo/env

alias login-lab="kitty +kitten ssh -Y 192.168.66.53 -l mgrange"
alias kix=". ~/repos/KIP/scripts/kix-runtime-setup/compile-kix-runtime.sh --features nic-forensics \
        && . ~/repos/KIP/scripts/kix-runtime-setup/launch-kix-runtime.sh"

alias kix-tests=". ~/repos/KIP/e2etests/run-tests.sh 172.26.72.1 172.26.72.100 hardware enx00e04c682293 enp2s0"
alias kix-unit-tests=". ~/repos/KIP/e2etests/JTAG-RPU-Tests.sh"

if [ -f /home/mgrange/.arkham-env/arkham-user-environment.sh ]; then
	. /home/mgrange/.arkham-env/arkham-user-environment.sh
fi
