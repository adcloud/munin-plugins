#!/usr/bin/env bash

CURRENT=`dirname $0`

rm /etc/munin/plugins/{redis,network,couchdb}*
ln -s $CURRENT/../plugins/{redis,network,couchdb}_* /etc/munin/plugins/
service munin-node reload