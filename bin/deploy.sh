#!/usr/bin/env bash

CURRENT=$(cd `dirname $0`; cd ..; pwd)

rm /etc/munin/plugins/{redis,network,couchdb}*
ln -s $CURRENT/plugins/{redis,network,couchdb}_* /etc/munin/plugins/
service munin-node reload