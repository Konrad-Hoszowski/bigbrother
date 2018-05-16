#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/common.sh

readConfig ${CFG_FILE}


#local constants
SCROT="/usr/bin/scrot"
SS_FLAGS="-z -q 20 -m"
SS_CMD="if [ \\\$s -lt $SCREEN_MIN_SIZE ]; then echo Removing \\\$f \\\$s; rm \\\$f; fi;"

function getDisplayNumber(){
	local user=${1}
	local display_num="`who | grep ${user} | grep  -e '(:[0-9])' | rev | cut -c2`"
	echo $display_num
}

function takeNewScreen(){
	local screens_dir=${1}
	local user=${2}

	local display_num=$(getDisplayNumber ${user})
	if [ -z "${display_num}" ];
	then
		echo "User ${user} not logged in"
	else
		ss_file="${screens_dir}/${user}/${user}-screen-%Y-%m-%d-%H_%M.png"
		echo "${screens_dir}/${user}/${user}-screen-%Y-%m-%d-%H_%M.png"
		sudo su -c "DISPLAY=:${display_num} ${SCROT} ${ss_file} ${SS_FLAGS} -e \"$SS_CMD\" " ${user}
	fi
}

#### MAIN #############################################################

#xhost + in .xinitrc


usage() { echo "usage: $0 [options] user" && grep " .)\ #" $0; exit 0; }
[ $# -eq 0 ] && usage
user=${1}

echo -n "Taking screenshot at [$(date '+%F %R:%S')] into: "
takeNewScreen ${SCREENS_DIR} ${user} 


