#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/common.sh

readConfig ${CFG_FILE}

function createUserFolders(){
	local screens_dir=${1}
	local user=${2}
	local group=${3}
	sudo install -o ${user} -g ${group} -d ${screens_dir}/${user}
}

function setupCronTakeScreen(){
	local install_dir=${1}
	local user=${2}
	local logFile="/tmp/${user}.screens.log"
	# every minute take a screen
	cron="*/1 * * * * ${install_dir}/bin/screens.sh ${user} >> ${logFile} 2>&1 "
	( crontab -l | grep -v -e "screens.*${user}" ; echo "${cron}" ) | crontab - 
}

function setupCronRemoveOldScreens(){
	local install_dir=${1}
	local user=${2}
	local logFile="/tmp/${user}.screens.log"
	#once and hour remove old files
	#cron="* */1 * * * sudo su -c \"${install_dir}/bin/removeOldScreens.sh ${user} >> ${logFile} 2>&1\" ${user} "
	cron="1 * * * * ${install_dir}/bin/removeOldScreens.sh ${user} >> ${logFile} 2>&1  "
	( crontab -l | grep -v -e "removeOldScreens.*${user}" ; echo "${cron}" ) | crontab - 
}

function showCronSetup(){
	local user=${1}
	echo "Cron settings for user $user:"
	crontab -l | grep ${user};
}

#### MAIN #############################################################

#xhost + in .xinitrc
# - Defaults

# - Main
usage() { echo "usage: $0 [options] user" && grep " .)\ #" $0; exit 0; }
[ $# -eq 0 ] && usage
user=${1}


createUserFolders ${SCREENS_DIR} ${user} ${GROUP}

setupCronTakeScreen ${INSTALL_DIR} ${user}

setupCronRemoveOldScreens ${INSTALL_DIR} ${user}

showCronSetup ${user}

