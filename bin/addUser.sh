#!/bin/bash


function createUserFolders(){
	local install_dir=${1}
	local user=${2}
	local group=${3}
	install -o $i -g ${group} -d ${install_dir}/${i}
}

function setupCron(){
	local install_dir=${1}
	local user=${2}
	cron="\"*/1 * * * * sudo su -c \"${install_dir}/bin/screens.sh >> /tmp/${user}.screens.log 2>&1\" ${user} \""
	( crontab -l | grep -v ${user} ; echo "${cron}" ) | crontab - 
}


#### MAIN #############################################################

#xhost + in .xinitrc
OWNER=bigbrother
GROUP=${OWNER}
INSTALL_DIR="/opt/bigbrother"

createUserFolders ${INSTALL_DIR} ${1} ${GROUP}

setupCron ${INSTALL_DIR} ${1}
