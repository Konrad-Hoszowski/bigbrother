bigbrother
parental control

## Installation procedure
Following steps should be executed to install BigBrother service

### Clone repository
Clones sources to you computer into `./bigbrother` folder
```
git clone git@github.com:Konrad-Hoszowski/bigbrother.git 
```

### Install files
Creates user bigbrother and installs all files into defualt `/opt/bigbrother` directory
```
cd ./bigbrother
sudo ./install_script.sh
```

### Add user to monitor
Creates cron task to monitor selected user
```
cd /opt/bigbrother
sudo ./bin/addUser.sh <user-to-monitor>
```

### Troubleshooting
To see all cron tasks defined for the bigbrother user execute `crontab -l`
```
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command

*/1 * * * * /opt/bigbrother/bin/screens.sh user1 >> /tmp/user1.screens.log 2>&1
1 * * * * /opt/bigbrother/bin/removeOldScreens.sh user1 >> /tmp/user1.screens.log 2>&1
*/1 * * * * /opt/bigbrother/bin/screens.sh user2 >> /tmp/user2.screens.log 2>&1
1 * * * * /opt/bigbrother/bin/removeOldScreens.sh user2 >> /tmp/user2.screens.log 2>&1
```
