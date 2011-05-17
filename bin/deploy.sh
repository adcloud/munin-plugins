#!/usr/bin/env bash

CURRENT=$(cd `dirname $0`; cd ..; pwd)

sudo rm /etc/munin/plugins/{redis,network,couchdb}*
sudo ln -s $CURRENT/plugins/{redis,network,couchdb}_* /etc/munin/plugins/
cd $CURRENT; npm install
sudo service munin-node reload
