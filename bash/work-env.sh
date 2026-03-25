#!bash

# Source Vivado and Vitis if they are installed:
if [ -d "/tools/Xilinx/" ]; then
  source /tools/Xilinx/Vivado/2024.2/settings64.sh
  source /tools/Xilinx/Vitis/2024.2/settings64.sh
fi

# Source cargo if it is installed:
if [ -d "$HOME/.cargo" ]; then
  source $HOME/.cargo/env
fi

# Only useful if we have kitty installed:
if command -v kitty >/dev/null 2>&1; then 
  alias login-lab="kitty +kitten ssh -Y 192.168.66.53 -l mgrange"
fi

# Only useful if we have the KIP repo installed:
if [ -d "$HOME/repos/KIP/" ]; then
  alias kix=". ~/repos/KIP/scripts/kix-runtime-setup/compile-kix-runtime.sh --features nic-forensics \
        && . ~/repos/KIP/scripts/kix-runtime-setup/launch-kix-runtime.sh"
  alias kix-tests=". ~/repos/KIP/e2etests/run-tests.sh 172.26.72.1 172.26.72.100 hardware enx00e04c682293 enp2s0"
  alias kix-unit-tests=". ~/repos/KIP/e2etests/JTAG-RPU-Tests.sh"
fi

# If we are not on a work machine then we wont have this:
if [ -f /home/mgrange/.arkham-env/arkham-user-environment.sh ]; then
	. /home/mgrange/.arkham-env/arkham-user-environment.sh
fi
