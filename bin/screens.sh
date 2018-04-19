#!/bin/bash

#DEBUG=true

function decho (){
	if [ ! -z "${DEBUG}" ];
	then
		echo $*
	fi	
}


##################################################################################

echo `date`

SCROT="/usr/bin/scrot"
SS_FLAGS="-z -q 20 -m"
SS_MIN_SIZE=22222 #if the screenshot file is smaller the file is not kept. 
SS_CMD=" if [ \$s -lt $SS_MIN_SIZE ]; then echo Removing \$f \$s; rm \$f; fi;"

DEST_PATH="/opt/bigbrother"

USER=`id -nu`

function getDisplayNumber(){
	local user=${1}
	display_num="`who | grep ${user} | grep  -e '(:[0-9])' | rev | cut -c2`"
	echo ${display_num}
}

DISPLAY_NUM=`getDisplayNumber ${USER}`

if [ -z "${DISPLAY_NUM}" ];
then
	echo "User ${USER} not logged in"
else
	SS_FILE="${DEST_PATH}/${USER}/${USER}-screen-%Y-%m-%d-%H_%M.jpg"
	DISPLAY=:${DISPLAY_NUM} ${SCROT} ${SS_FILE} ${SS_FLAGS} -e "$SS_CMD"
	decho DISPLAY=:${DISPLAY_NUM} ${SCROT} ${SS_FILE} ${SS_FLAGS} -e "$SS_CMD"

fi
