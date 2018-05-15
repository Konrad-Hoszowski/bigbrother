# bigbrother
# parental control

# Installation procedure
Following steps should be executed to install BigBrother service

Clone repository
	git clone git@github.com:Konrad-Hoszowski/bigbrother.git 

Create user bigbrother and installs all files into defualt /opt/bigbrother directory
	cd ./bigbrother
	sudo ./install_script.sh

add user to monitor
	cd /opt/bigbrother
	sudo ./bin/addUser.sh <user-to-monitor>
