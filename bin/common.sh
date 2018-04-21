#!/bin/bash

function readConfigValue(){
	local configFile=${1}
	local keyName=${2}
	local retVal=$(grep "${keyName}" ${configFile} | cut -d'=' -f2)
	echo ${retVal}
}

function readConfig(){
	local configFile=${1}
	KEEP_NUM_FILES=$(readConfigValue ${configFile} "max-number-of-screenshots-to-keep")
	SCREEN_MIN_SIZE=$(readConfigValue ${configFile} "min-size-of-screenshot-to-keep")
}

function showCronSetup(){
	local user=${1}
	echo "Cron settings for user $user:"
	crontab -l | grep ${user};
}

#### DEFAULTS #############################################################

OWNER=bigbrother
GROUP=${OWNER}
SUDO_GRP=admin
INSTALL_DIR="/opt/bigbrother"
CFG_FILE="${INSTALL_DIR}/config/bigbrother.properties"
SCREENS_DIR="${INSTALL_DIR}/screens"
KEEP_NUM_FILES=1000 
SCREEN_MIN_SIZE=22222
