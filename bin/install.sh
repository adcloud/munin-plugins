#!/usr/bin/env bash

TYPE=$1

case $TYPE in
adserver)
   PLUGIN_PATTERN="ac redis couchdb";;
riak)
   PLUGIN_PATTERN="riak";;
redis)
   PLUGIN_PATTERN="redis";;
esac

ALL_PLUGINS_PATTERN="ac redis network couchdb"

echo "Installing dependencies..."; echo
sudo apt-get install ruby1.8-dev
[ ! -e "/bin/env" ] && sudo ln -s /usr/bin/env /bin/env
sudo gem install redis SystemTimer

echo
echo "Installing plugins..."
echo
echo "npm install..."
echo
cd ~/munin-plugins
rm -rf node_modules
npm install

echo
echo
echo "=====> removing old plugins form /etc/munin/plugins"
for plugin_prefix in $ALL_PLUGINS_PATTERN
do
  echo "-> removing $plugin_prefix*"
  sudo rm -f /etc/munin/plugins/${plugin_prefix}*
done

echo
echo "=====> linking new plugins to /etc/munin/plugins"
for plugin_prefix in $PLUGIN_PATTERN
do
  echo "-> linking $plugin_prefix*"
  sudo ln -s /home/lisa/munin-plugins/plugins/${plugin_prefix}_* /etc/munin/plugins/
done

echo
echo "Restarting munin-node"
sudo restart munin-node

echo
echo "Installed plugins"
echo "-----------------------------------------------------------------------"
cd /etc/munin/plugins
for plugin_prefix in $ALL_PLUGINS_PATTERN
do
  ls ${plugin_prefix}_*
done

