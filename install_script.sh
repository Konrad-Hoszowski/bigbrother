#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${DIR}/bin/common.sh

function installFiles()	{
	local install_dir=${1}
	local owner=${2}
	local group=${3}
	install -d ${install_dir}
	install -d ${install_dir}/bin
	install -d ${install_dir}/config
	install -d ${install_dir}/screens
	install -C -D  ./bin/* ${install_dir}/bin
	install -C -D  ./config/* ${install_dir}/config
	chown -R ${owner}:${group} ${install_dir}

}

#### MAIN #############################################################

#apt get install -y scrot npm

#npm i -g http_server

#xhost + in .xinitrc


useradd -d ${INSTALL_DIR} -G ${SUDO_GRP} -M -U -s /bin/bash ${OWNER} 
installFiles ${INSTALL_DIR} ${OWNER} ${GROUP}

