#                     _                         _
#                    | |                       | |
# __      _____  _ __| | __  ___ _ ____   _____| |__
# \ \ /\ / / _ \| '__| |/ / / _ \ '_ \ \ / / __| '_ \
#  \ V  V / (_) | |  |   < |  __/ | | \ V /\__ \ | | |
#   \_/\_/ \___/|_|  |_|\_\ \___|_| |_|\_(_)___/_| |_|
#                      ______
#                     |______|

# Source Vivado and Vitis if they are installed:
if [ -d "/tools/Xilinx/2025.2/" ]; then
	source /tools/Xilinx/2025.2/Vivado/settings64.sh
	source /tools/Xilinx/2025.2/Vitis/settings64.sh
fi

alias kip-serial="tail -F -n 10 /home/mgrange/repos/KIP/deploy-kip-workspace/serial.log /home/mgrange/repos/KIP/deploy-kip-workspace/kip.log"
alias login-lab="kitty +kitten ssh -Y 192.168.66.53 -l mgrange"

# Only useful if we have kitty installed:
if command -v kitty >/dev/null 2>&1; then
	alias login-lab="kitty +kitten ssh -Y 192.168.66.53 -l mgrange"
fi

# Only useful if we have the KIP repo installed:
if [ -d "$HOME/repos/KIP/" ]; then
	alias kip="$HOME/repos/dotfiles/scripts/kip.sh"
fi

# If we are not on a work machine then we wont have this:
if [ -f /home/mgrange/.arkham-env/arkham-user-environment.sh ]; then
	. /home/mgrange/.arkham-env/arkham-user-environment.sh
fi
