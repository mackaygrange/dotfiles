#                     _                         _
#                    | |                       | |
# __      _____  _ __| | __  ___ _ ____   _____| |__
# \ \ /\ / / _ \| '__| |/ / / _ \ '_ \ \ / / __| '_ \
#  \ V  V / (_) | |  |   < |  __/ | | \ V /\__ \ | | |
#   \_/\_/ \___/|_|  |_|\_\ \___|_| |_|\_(_)___/_| |_|
#                      ______
#                     |______|

# Source Vivado and Vitis if they are installed:
if [ -d "/tools/Xilinx/" ]; then
	source /tools/Xilinx/Vivado/2024.2/settings64.sh
	source /tools/Xilinx/Vitis/2024.2/settings64.sh
fi

alias login-lab="kitty +kitten ssh -Y 192.168.66.53 -l mgrange"

# Only useful if we have kitty installed:
if command -v kitty >/dev/null 2>&1; then
	alias login-lab="kitty +kitten ssh -Y 192.168.66.53 -l mgrange"
fi

# Only useful if we have the KIP repo installed:
if [ -d "$HOME/repos/KIP/" ]; then
	alias kix="~/repos/KIP/scripts/kix-runtime-setup/compile-kix-runtime.sh --features nic-forensics \
          && ~/repos/KIP/scripts/kix-runtime-setup/launch-kix-runtime.sh"
	alias kix-rpu="~/repos/KIP/scripts/kix-runtime-setup/build-rpu.sh --features nic-forensics \
        && ~/repos/KIP/scripts/kix-runtime-setup/launch-kix-runtime.sh"
	alias kix-full="~/repos/KIP/scripts/kix-runtime-setup/compile-kix-runtime.sh --features nic-forensics \
        && ~/repos/KIP/scripts/kix-runtime-setup/launch-kix-runtime.sh \
        && kix-tests"
	alias kix-tests="~/repos/KIP/e2etests/run-tests.sh 172.26.72.1 172.26.72.100 hardware enx00e04c682293 enx00e04c351a8d"
	alias kix-unit-tests="~/repos/KIP/e2etests/JTAG-RPU-Tests.sh"
fi

# If we are not on a work machine then we wont have this:
if [ -f /home/mgrange/.arkham-env/arkham-user-environment.sh ]; then
	. /home/mgrange/.arkham-env/arkham-user-environment.sh
fi
