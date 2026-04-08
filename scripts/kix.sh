#!/bin/bash

##  +==============================================================================================================+  ##
##  |                                        ARKHAM TECHNOLOGY PROPRIETARY                                         |  ##
##  |                                                     CUI                                                      |  ##
##  |                                                                                                              |  ##
##  |  DISTRIBUTION STATEMENT B:                                                                                   |  ##
##  |  Distribution authorized to Department of Defense only for Administrative or Operational Use, Controlled     |  ##
##  |  Technical Information (CTI), Export Controlled (EXPT), DFARS SBIR Data Rights (SBIZ), Proprietary           |  ##
##  |  Information (PROPIN). See date below. Other requests for this document shall be referred to DARPA/I2O,      |  ##
##  |  675 North Randolph Street, Arlington, VA 22203-2114.                                                        |  ##
##  |                                                                                                              |  ##
##  |  CONTROLLED UNCLASSIFIED INFORMATION:                                                                        |  ##
##  |  This document contains information exempt from public disclosure under the Freedom of Information Act       |  ##
##  |  5 U.S.C. 552, as amended). Exemption 3 and 4 applies. The information herein that is marked                 |  ##
##  |  “CONTROLLED UNCLASSIFIED INFORMATION” or “CUI” is for the exclusive use of the DoD, other U.S. Government,  |  ##
##  |  and U.S. contractor personnel with a need-to-know. Such information is specifically prohibited from posting |  ##
##  |  on unrestricted bulletin boards or other unlimited access applications, and to an e-mail alias.             |  ##
##  |                                                                                                              |  ##
##  |  EXPORT WARNING:                                                                                             |  ##
##  |  This document contains technical data whose export is restricted by the Arms Export Control Act (22 U.S.C.  |  ##
##  |  2751, et seq.) or the Export Control Act of 2018 (Title 50, U.S.C., Chapter 58, Sec. 4801-4852.). Violations|  ##
##  |  of these export laws are subject to severe criminal penalties. Dissemination of this document is controlled |  ##
##  |  under DoD Directive 5230.25.                                                                                |  ##
##  |                                                                                                              |  ##
##  |  SBIR DATA RIGHTS:                                                                                           |  ##
##  |  Contract No.: HR0011-21-C-0116. Contractor: 47RG0.                                                          |  ##
##  |  Expiration of SBIR Data Rights: 20 years after completion of project work for this or any follow-on SBIR    |  ##
##  |  contract, whichever is later. The Government’s rights to use, modify, reproduce, release, perform, display, |  ##
##  |  or disclose technical data or computer software marked with this legend are restricted during the period    |  ##
##  |  shown as provided in paragraph (b)(4) of the Rights in Noncommercial Technical Data and Computer Software - |  ##
##  |  Small Business Innovation Research (SBIR) Program clause contained in the above identified contract. No     |  ##
##  |  restrictions apply after the expiration date shown above. Any reproduction of technical data, computer      |  ##
##  |  software, or portions thereof marked with this legend must also reproduce the markings.                     |  ##
##  |                                                                                                              |  ##
##  |  CAUTION - PROPRIETARY INFORMATION INVOLVED:                                                                 |  ##
##  |  This information is provided under an express or implied understanding that the information will be         |  ##
##  |  protected as a proprietary trade secret or proprietary data believed to have actual or potential value.     |  ##
##  |  Information bearing this marking shall not be disseminated outside the federal government in any form       |  ##
##  |  without the express permission of the originator of the information and provider of the proprietary         |  ##
##  |  information. This marking precludes dissemination to contractors irrespective of their status to, or within,|  ##
##  |  the U.S. Government without the authorization of the originator of the information and provider of the      |  ##
##  |  information.  Disclosure of this information is restricted by the Trade Secrets Act                         |  ##
##  |  (18 U.S.C. 1905, et seq.).  The Government’s rights to use, modify, reproduce, release, perform, display, or|  ##
##  |  disclose technical data contained in this document are restricted by paragraph (b)(2) of the Rights in      |  ##
##  |  Technical Data – Noncommercial Items clause (DFARS 252.227-7013 (Nov 1995)). Any reproduction of technical  |  ##
##  |  data or portions thereof marked with this legend must also reproduce the markings. Any person, other than   |  ##
##  |  the Government, who has been provided access to such data must promptly notify the above-named contractor.  |  ##
##  |                                                                                                              |  ##
##  |  DESTRUCTION NOTICE:                                                                                         |  ##
##  |  Destroy by any method that will prevent disclosure of contents or reconstruction of the document.           |  ##
##  |                                                                                                              |  ##
##  |                                                                       Controlled by:  DARPA                  |  ##
##  |                                                                       Controlled by:  DARPA/I2O              |  ##
##  |                                                                       CUI Category:  CTI, EXPT, SBIZ, PROPIN |  ##
##  |                                                                       Distribution Statement: B              |  ##
##  |                                                                       POC:  FSO - CAGE 47RG0, 949-585-0404   |  ##
##  |                                                                                                              |  ##
##  |  ©2018-2026 Arkham Technology Ltd., All Rights Reserved                                                      |  ##
##  +==============================================================================================================+  ##

##  +==============================================================================================================+  ##
##  |                                                     OVERVIEW                                                 |  ##
##  |                                                                                                              |  ##
##  |  Description:                                                                                                |  ##
##  |  Tool to streamline testing of kip by unifying the relevant scripts within a single interface                |  ##
##  |                                                                                                              |  ##
##  |  Author: Mackay Grange                                                                                       |  ##
##  |  Date: 2026-04-07                                                                                            |  ##
##  +==============================================================================================================+  ##

#  _    _            _
# | |  (_)          | |
# | | _____  __  ___| |__
# | |/ / \ \/ / / __| '_ \
# |   <| |>  < _\__ \ | | |
# |_|\_\_/_/\_(_)___/_| |_|

# NOTE: You will need to edit the ARGS_* env vars to reflect the interfaces / IP addresses for your specific board
# NOTE: Reach out to Mackay Grange if you have any features for the script you want me to add or if changes to the
# repo break the script in some way. I also haven't tested the script SUPER thoroughly so if you find bugs let me know.

set -Eeu -o pipefail
shopt -s inherit_errexit

# Declare Default Var Values:
KIP_DIR=""

FLAG_COMPILE=false
FLAG_BUILD=false
FLAG_LAUNCH=false
FLAG_E2E=false
FLAG_UNIT=false
FLAG_SIPE=false
FLAG_KG42=false
FLAG_ESP=false
FLAG_ZEROIZE=false
FLAG_CONF=false

PATH_COMPILE=""
PATH_BUILD=""
PATH_LAUNCH=""
PATH_E2E=""
PATH_UNIT=""
PATH_SIPE=""
PATH_KG42=""
PATH_ESP=""
PATH_ZEROIZE=""

ARGS_COMPILE=(--features nic-forensics)
ARGS_BUILD=(--features nic-forensics)
ARGS_LAUNCH=()
ARGS_E2E=(172.26.72.1 172.16.0.1 hardware enx00e04c682293 enx00e04c351a8d)
ARGS_UNIT=()
ARGS_SIPE=(--all)
ARGS_KG42=(--red-if enx00e04c682293 --black-if enx00e04c680e70)
ARGS_ESP=(--red-if enx00e04c682293 --black-if enx00e04c680e70)
ARGS_CONF=(--configure-board)
ARGS_ZEROIZE=(--device-ip 172.26.72.1)

# Usage Info:
usage() {
	echo "Usage: $0 [-h] [-c] [-b] [-l] [-t] [-u] [-s] [-k] [-e] [-i] [-z]"
	echo ""
	echo "[!] IF YOU ARE HAVING ISSUES: You will need to edit the ARGS_* env vars to reflect the interfaces / IP addresses for your specific board"
	echo ""
	echo "[-h] : View helpful information on usage"
	echo "[-c] : Add kix compilation step"
	echo "[-b] : Add kix rpu-build step"
	echo "[-l] : Add kix launch step"
	echo "[-t] : Add e2e tests step"
	echo "[-u] : Add unit tests step"
	echo "[-s] : Add sipe configuration tests step"
	echo "[-k] : Add kg42 tests step"
	echo "[-e] : Add esp tests step"
	echo "[-i] : Add --configure-board flag to esp/kg42 tests"
	echo "[-z] : Add zeroize tests step"
	echo "[-a] : Add all possible steps [-c] [-u] [-l] [-t]"
	exit 2
}

# Handle Arg Parsing:
parse_args() {
	if [ "$#" -eq 0 ]; then
		usage
	fi

	OPTIND=1
	while getopts ":hcbltuskeiza" opt; do
		case $opt in
		h) usage ;;
		c) FLAG_COMPILE=true ;;
		b) FLAG_BUILD=true ;;
		l) FLAG_LAUNCH=true ;;
		t) FLAG_E2E=true ;;
		u) FLAG_UNIT=true ;;
		s) FLAG_SIPE=true ;;
		k) FLAG_KG42=true ;;
		e) FLAG_ESP=true ;;
		i) FLAG_CONF=true ;;
		z) FLAG_ZEROIZE=true ;;
		a)
			FLAG_COMPILE=true
			FLAG_LAUNCH=true
			FLAG_E2E=true
			FLAG_UNIT=true
			;;
		\?) usage ;;
		esac
	done
}

# Prepare Necessary Paths:
set_paths() {
	# Locate KIP Repository:
	echo "[*] Finding KIP Directory!"
	KIP_DIR=$(find "$HOME" -maxdepth 3 -type d -name "KIP" -print -quit)
	if [ -d "$KIP_DIR" ]; then
		echo "[OK] KIP Directory found: $KIP_DIR"
	else
		echo "[!] Unable to locate KIP Directory! Ensure it is installed, and less than three depth levels from $HOME."
		exit 1
	fi

	# Set Paths:
	PATH_COMPILE="$KIP_DIR/scripts/kix-runtime-setup/compile-kix-runtime.sh"
	PATH_BUILD="$KIP_DIR/scripts/kix-runtime-setup/build-rpu.sh"
	PATH_LAUNCH="$KIP_DIR/scripts/kix-runtime-setup/launch-kix-runtime.sh"
	PATH_E2E="$KIP_DIR/e2etests/run-tests.sh"
	PATH_UNIT="$KIP_DIR/e2etests/JTAG-RPU-Tests.sh"
	PATH_SIPE="$KIP_DIR/e2etests/verification_tests/scripts/sipe_config_tests.py"
	PATH_KG42="$KIP_DIR/e2etests/verification_tests/kg42-tests.py"
	PATH_ESP="$KIP_DIR/e2etests/verification_tests/scripts/esp_tests.py"
	PATH_ZEROIZE="$KIP_DIR/e2etests/zeroize-tests.py"
}

# Logic to execute commands based on which flags are present:
execute_commands() {
	if $FLAG_COMPILE; then
		echo "[*] Compiling..."
		echo "[+] Executing Command: $PATH_COMPILE ${ARGS_COMPILE[*]}"
		"$PATH_COMPILE" "${ARGS_COMPILE[@]}"
		echo "[OK] KIX runtime compiled successfully!"
	fi

	if $FLAG_BUILD; then
		if $FLAG_COMPILE; then
			echo "[!] Compile flag (-c) already built the RPU, skipping build flag (-b)..."
		else
			echo "[*] Building..."
			echo "[+] Executing Command: $PATH_BUILD ${ARGS_BUILD[*]}"
			"$PATH_BUILD" "${ARGS_BUILD[@]}"
			echo "[OK] RPU built successfully!"
		fi
	fi

	if $FLAG_UNIT; then
		echo "[*] Running Unit Tests..."
		echo "[+] Executing Command: $PATH_UNIT ${ARGS_UNIT[*]}"
		"$PATH_UNIT" "${ARGS_UNIT[@]}"
		echo "[OK] Unit tests have finished successfully!"
	fi

	if $FLAG_LAUNCH; then
		echo "[*] Launching..."
		echo "[+] Executing Command: $PATH_LAUNCH ${ARGS_LAUNCH[*]}"
		"$PATH_LAUNCH" "${ARGS_LAUNCH[@]}"
		echo "[OK] KIX runtime has launched successfully!"
	fi

	if $FLAG_E2E; then
		echo "[*] Running E2E Tests..."
		echo "[+] Executing Command: $PATH_E2E ${ARGS_E2E[*]}"
		"$PATH_E2E" "${ARGS_E2E[@]}"
		echo "[OK] E2E tests have finished successfully!"
	fi

	if $FLAG_SIPE; then
		if $FLAG_E2E; then
			echo "[!] KG42 tests have already been run! Skipping step."
		else
			echo "[*] Running SIPE tests..."
			echo "[+] Executing Command: $PATH_SIPE ${ARGS_SIPE[*]}"
			"$PATH_SIPE" "${ARGS_SIPE[@]}"
			echo "[OK] SIPE tests have finished successfully!"
		fi
	fi

	if $FLAG_KG42; then
		if $FLAG_E2E; then
			echo "[!] KG42 tests have already been run! Skipping step."
		else
			if $FLAG_CONF; then
				echo "[*] Running KG42 tests... (with board configuration)"
				echo "[+] Executing Command: $PATH_KG42 ${ARGS_KG42[*]} ${ARGS_CONF[*]}"
				"$PATH_KG42" "${ARGS_KG42[@]}" "${ARGS_CONF[@]}"
			else
				echo "[*] Running KG42 tests..."
				echo "[+] Executing Command: $PATH_KG42 ${ARGS_KG42[*]}"
				"$PATH_KG42" "${ARGS_KG42[@]}"
			fi
			echo "[OK] KG42 tests have finished successfully!"
		fi
	fi

	if $FLAG_ESP; then
		if $FLAG_E2E; then
			echo "[!] ESP tests have already been run! Skipping step."
		else
			if $FLAG_KG42; then
				echo "[!] Running ESP tests after KG42 tests requires a board relaunch!"
				echo "[*] Relaunching..."
				echo "[+] Executing Command: $PATH_LAUNCH ${ARGS_LAUNCH[*]}"
				"$PATH_LAUNCH" "${ARGS_LAUNCH[@]}"
				echo "[OK] KIX runtime has relaunched successfully!"
			fi

			if $FLAG_CONF; then
				echo "[*] Running ESP tests... (with board configuration)"
				echo "[+] Executing Command: $PATH_ESP ${ARGS_ESP[*]} ${ARGS_CONF[*]}"
				"$PATH_ESP" "${ARGS_ESP[@]}" "${ARGS_CONF[@]}"
			else
				echo "[*] Running ESP tests..."
				echo "[+] Executing Command: $PATH_ESP ${ARGS_ESP[*]}"
				"$PATH_ESP" "${ARGS_ESP[@]}"
			fi
			echo "[OK] ESP tests have finished successfully!"
		fi
	fi

	if $FLAG_ZEROIZE; then
		if $FLAG_E2E; then
			echo "[!] Zeroize tests have already been run! Skipping step."
		else
			echo "[*] Running Zeroize tests..."
			echo "[+] Executing Command: $PATH_ZEROIZE ${ARGS_ZEROIZE[*]}"
			"$PATH_ZEROIZE" "${ARGS_ZEROIZE[@]}"
			echo "[OK] Zeroize tests have finished successfully!"
		fi
	fi

	# If no flags are set, display usage:
	if ! $FLAG_COMPILE && ! $FLAG_BUILD && ! $FLAG_LAUNCH && ! $FLAG_E2E && ! $FLAG_UNIT && ! $FLAG_SIPE && ! $FLAG_KG42 && ! $FLAG_ESP && ! $FLAG_ZEROIZE; then
		usage
	fi
}

# =================
# MAIN PROGRAM BODY
# =================

parse_args "$@"
set_paths
execute_commands

exit 0

##  +==============================================================================================================+  ##
##  |                                                     CUI                                                      |  ##
##  |                                        ARKHAM TECHNOLOGY PROPRIETARY                                         |  ##
##  +==============================================================================================================+  ##
