#!/bin/bash

echo `date`
USER=`id -nu`
DISPLAY_NUM="`who | grep $USER | grep  -e '(:[0-9])' | rev | cut -c2`"

echo display_number ${DISPLAY_NUM}

if [ -z "${DISPLAY_NUM}" ];
then
	echo "User ${USER} not logged in"
else
	SCROT="/usr/bin/scrot"
	DEST_PATH="/opt/bigbrother/$USER/"

	echo DISPLAY=":${DISPLAY_NUM}" ${SCROT} "${USER}-screen-%Y-%m-%d-%H_%M.jpg" -z -q 20 -e "mv ${USER}-screen*.jpg ${DEST_PATH}"
	DISPLAY=":${DISPLAY_NUM}" ${SCROT} "${USER}-screen-%Y-%m-%d-%H_%M.jpg" -z -q 20 -e "mv ${USER}-screen*.jpg ${DEST_PATH}"
fi
