#!/bin/bash



function installFiles()	{
	local install_dir=${1}
	local owner=${2}
	local group=${3}
	install -d ${install_dir}
	install -d ${install_dir}/bin
	install -C -D  ./bin/* ${install_dir}/bin
	chown -R ${owner}:${group} ${install_dir}

}

function createUserFolders(){
	local install_dir=${1}
	local prop_file=${2}
	local group=${3}
	for i in `cat ${prop_file}`; do
		install -o $i -g ${group} -d ${install_dir}/${i}
	done;
}

#### MAIN #############################################################

#apt get install -y scrot npm

#npm i -g http_server

#xhost + in .xinitrc
OWNER=bigbrother
GROUP=${OWNER}
INSTALL_DIR="/opt/bigbrother"

useradd -d ${INSTALL_DIR} -G adm -M -U -s /bin/bash ${OWNER} 

installFiles ${INSTALL_DIR} ${OWNER} ${GROUP}

createUserFolders ${INSTALL_DIR} ${1} ${GROUP}

