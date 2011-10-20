#!/usr/bin/env bash

CURRENT_DIR=$(cd `dirname $0`; cd ..; pwd)
REMOTE_DIR="~/munin-plugins"
PREFIX="~"
SERVER=$1
TYPE=$2

if test -z $SERVER; then
  echo "ERROR: no server given"
  exit 1
fi
if test -z $TYPE; then
  echo "ERROR: no type (adserver, redis, riak) given"
  exit 2
fi

echo "Deploying plugins..."
echo
rsync --rsh 'ssh' \
      --exclude "node_modules/" \
      --exclude ".git/" \
      --delete \
      --compress \
      --recursive \
      $CURRENT_DIR $SERVER:$PREFIX

# install
ssh $SERVER "cd $REMOTE_DIR && ./bin/install.sh $TYPE"