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
	install -d ${install_dir}/web/src/client/components
	install -C -D -m 755 ./bin/* ${install_dir}/bin
	install -C -D -m 644 ./config/* ${install_dir}/config
	install -C -D -m 644 ./web/* ${install_dir}/web
	install -C -D -m 644 ./web/src/* ${install_dir}/web/src
	install -C -D -m 644 ./web/src/client/* ${install_dir}/web/src/client
	install -C -D -m 644 ./web/src/client/components/* ${install_dir}/web/src/client/components
	chown ${owner}:${group} ${install_dir}
	chown ${owner}:${group} ${install_dir}/screens
	chown -R ${owner}:${group} ${install_dir}/bin
	chown -R ${owner}:${group} ${install_dir}/config
	chown -R ${owner}:${group} ${install_dir}/web

}

#### MAIN #############################################################

#apt get install -y scrot npm

#npm i -g http_server

#xhost + in .xinitrc


useradd -d ${INSTALL_DIR} -G ${SUDO_GRP} -M -U -s /bin/bash ${OWNER} 
installFiles ${INSTALL_DIR} ${OWNER} ${GROUP}

