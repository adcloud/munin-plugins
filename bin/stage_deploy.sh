#!/usr/bin/env bash

CURRENT=$(cd `dirname $0`; cd ..; pwd)

POST_COPY_COMMANDS="sudo rm /etc/munin/plugins/{ac,redis,network,couchdb}*;
sudo ln -s /home/lisa/munin-plugins/plugins/{ac,redis,couchdb}_* /etc/munin/plugins/;
sudo restart munin-node"

scp -Cr $CURRENT/* $1:~/munin-plugins
ssh $1 "sudo apt-get install ruby1.8-dev && sudo ln -s /usr/bin/env /bin/env && sudo gem install redis SystemTimer"
ssh $1 "mkdir -p /home/lisa/munin-plugins/ && cd /home/lisa/munin-plugins/ && rm -rf node_modules && npm install"
ssh $1 $POST_COPY_COMMANDS
