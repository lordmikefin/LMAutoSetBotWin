#!/bin/bash

# Copyright (c) 2017, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
# 
# License of this script file:
#   MIT License
# 
# License is available online:
#   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE.rst
# 
# Latest version of this script file:
#   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/init.sh


# init.sh
# This script will install minimal set of required apps.



unset CURRENT_SCRIPT_VER CURRENT_SCRIPT_DATE
CURRENT_SCRIPT_VER="0.0.2"
CURRENT_SCRIPT_DATE="2019-07-09"
echo "CURRENT_SCRIPT_VER: ${CURRENT_SCRIPT_VER} (${CURRENT_SCRIPT_DATE})"




CURRENT_SCRIPT_REALPATH=$(realpath ${BASH_SOURCE[0]})
CURRENT_SCRIPT_DIR=$(dirname ${CURRENT_SCRIPT_REALPATH})
CURRENT_SCRIPT=$(basename ${CURRENT_SCRIPT_REALPATH})
LM_TOYS_DIR=$(realpath "${CURRENT_SCRIPT_DIR}/submodule/LMToysBash")
#IMPORT_FUNCTIONS="$(realpath "${CURRENT_SCRIPT_DIR}/../../script/lm_functions.sh")"
IMPORT_FUNCTIONS=$(realpath "${LM_TOYS_DIR}/lm_functions.sh")
if [[ ! -f "${IMPORT_FUNCTIONS}" ]]; then
	>&2 echo "${BASH_SOURCE[0]}: line ${LINENO}: Source script '${IMPORT_FUNCTIONS}' missing!"
	exit 1
fi

source ${IMPORT_FUNCTIONS}

if [ ${LM_FUNCTIONS_LOADED} == false ]; then
	>&2 echo "${BASH_SOURCE[0]}: line ${LINENO}: Something went wrong while loading functions."
	exit 1
elif [ ${LM_FUNCTIONS_VER} != "1.2.1" ]; then
	lm_functions_incorrect_version
	if [ "${INPUT}" == "FAILED" ]; then
		lm_failure
	fi
fi






# NOTE to myself: Read more about executeing commands from filename in Bash.
#   ( https://superuser.com/questions/46139/what-does-source-do )

# NOTE to myself: Read more about Bash conditional statements.
#   ( http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html )

# NOTE to myself: Read more about how to get distribuiton info.
#   ( https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script )

unset DISTRO_INFO IS_UBUNTU EXEC_MATE_ABOUT IS_MATE
DISTRO_INFO="/etc/os-release"
if [[ -r "${DISTRO_INFO}" ]] ; then
	source "${DISTRO_INFO}" # Executeing commands from file. Import variables.
else
	echo -e "\n '${DISTRO_INFO}' file missing or is not readable.  Aborting." >&2
	exit 1
fi
#echo -e "\n Distro name: ${NAME}, Version: ${VERSION}"

#if [[ ${NAME} != "Ubuntu" ]] ; then
#	echo -e "\n This script is tested only with Ubuntu.  Aborting." >&2
#	exit 1
#fi

case ${NAME} in
	Ubuntu )
		echo "Distro is Ubuntu" 
		IS_UBUNTU=1 ;;
	* )
		echo -e "\n This script is tested only with Ubuntu.  Aborting." >&2
		exit 1
		;;
esac

if [[ ${IS_UBUNTU} -eq 1 ]] ; then
	#which mate-about >/dev/null && { echo "Is MATE"; echo "$(mate-about -v)"; }
	EXEC_MATE_ABOUT="$(which mate-about)"
	#echo "EXEC_MATE_ABOUT: '${EXEC_MATE_ABOUT}'"
	if [[ -n ${EXEC_MATE_ABOUT} ]] ; then
		IS_MATE=1
		echo "$(${EXEC_MATE_ABOUT} -v)"
	else
		echo -e "\n 'mate-about' is not installed."
		echo -e "\n This script is tested only with MATE.  Aborting." >&2
		exit 1
	fi
else
	echo -e "\n This script is tested only with UBUNTU.  Aborting." >&2
	exit 1
fi




#echo -e "\n This script is in test mode :)  Aborting." >&2
#exit 1



# TODO: Should I check version of these apps?  *sigh*

echo ""
#GIT_VERSION=$(lm_get_git_version)  || lm_failure
APP_GIT="git"
GIT_VERSION=$(lm_get_app_version ${APP_GIT})  || lm_failure
#echo ${GIT_VERSION}
if [ -z "${GIT_VERSION}" ] ; then
	echo "'${APP_GIT}' is not installed !"
else
	echo "'${APP_GIT}' is installed."
fi



echo ""
APP_PY="python3"
PY_VERSION=$(lm_get_app_version ${APP_PY})  || lm_failure
#echo ${PY_VERSION}
if [ -z "${PY_VERSION}" ] ; then
	echo "'${APP_PY}' is not installed !"
else
	echo "'${APP_PY}' is installed."
fi


echo ""
APP_PIP="pip3"
PIP_VERSION=$(lm_get_app_version ${APP_PIP})  || lm_failure
if [ -z "${PIP_VERSION}" ] ; then
	echo "'${APP_PIP}' is not installed !"
else
	echo "'${APP_PIP}' is installed."
fi



#echo "This script is in test mode :)  Aborting." >&2
#exit 1 # 127



lm_incomplete_message () {
	>&2 echo ""
	>&2 echo "All applications suggested by this script should be installed"
    >&2 echo "before you continue to real script (Python)."
	>&2 echo ""
}


if [ -z "${GIT_VERSION}" ] ; then
	#echo "'${APP_GIT}' is not installed !"
	unset INPUT
	lm_read_to_INPUT "Do you want to install the 'git'?"
	case "${INPUT}" in
		"YES" )
			sudo apt-get install git
			;;
		"NO" )
			echo "Ok then. Bye."
			lm_incomplete_message
			exit 1
			;;
		"FAILED" | * )
			lm_failure_message
			;;
	esac
fi

if [ -z "${PY_VERSION}" ] ; then
	#echo "'${APP_PY}' is not installed !"
	unset INPUT
	lm_read_to_INPUT "Do you want to install the 'python3'?"
	case "${INPUT}" in
		"YES" )
			sudo apt-get install python3
			;;
		"NO" )
			echo "Ok then. Bye."
			lm_incomplete_message
			exit 1
			;;
		"FAILED" | * )
			lm_failure_message
			;;
	esac
fi

if [ -z "${PIP_VERSION}" ] ; then
	unset INPUT
	lm_read_to_INPUT "Do you want to install the 'python3-pip'?"
	case "${INPUT}" in
		"YES" )
			sudo apt-get install python3-pip
			;;
		"NO" )
			echo "Ok then. Bye."
			lm_incomplete_message
			exit 1
			;;
		"FAILED" | * )
			lm_failure_message
			;;
	esac
fi



#echo "This script is in test mode :)  Aborting." >&2
#exit 1 # 127





echo ""
echo "Now you continue to real script (Python)."
echo "   TODO: Add guide."
echo ""
echo "End of script '${CURRENT_SCRIPT}'"

