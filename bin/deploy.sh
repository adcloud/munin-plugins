#!/usr/bin/env bash

CURRENT=$(cd `dirname $0`; cd ..; pwd)

rm /etc/munin/plugins/{ac,redis,network,couchdb}*
ln -s $CURRENT/plugins/{ac,redis,network,couchdb}_* /etc/munin/plugins/
cd $CURRENT; npm install
service munin-node restart