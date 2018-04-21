#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/common.sh

readConfig ${CFG_FILE}

function removeOldScreens(){
        local screens_dir=${1}
        local user=${2}
		local keep_num_files=${3}
        local ssPath="${screens_dir}/${user}/${user}-screen*.jpg"

        filesToRemove=$(expr $(ls -1 ${ssPath} | wc -l) - ${keep_num_files})
        echo "Files to remove: ${filesToRemove}"
        for i in $(ls -1 ${ssPath} | sort | head -n ${filesToRemove}); do
                echo "Removing ${i}"
                sudo su -c "rm -rf $i" ${user}
        done;

}

#### MAIN #############################################################

#xhost + in .xinitrc


usage() { echo "usage: $0 [options] user" && grep " .)\ #" $0; exit 0; }
[ $# -eq 0 ] && usage
user=${1}

echo "Files to keep: ${KEEP_NUM_FILES}"
removeOldScreens ${SCREENS_DIR} ${user} ${KEEP_NUM_FILES}


