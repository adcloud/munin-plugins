#!/bin/sh
#
# Plugin to monitor TCP states.
#
# Parameters:
#
#   config   (required)
#   autoconf (optional - only used by munin-config)
#
# (C) Marki - count number of connections in each state
#           - no LISTEN as we are running netstat without the "-a" option
#
#
# Magic markers (optional - used by munin-config and some installation
# scripts):
#%# family=auto
#%# capabilities=autoconf


if [ "$1" = "autoconf" ]; then
  if ( netstat -nt 2>/dev/null >/dev/null ); then
    echo yes
    exit 0
  else
    if [ $? -eq 127 ]
    then
      echo "no (netstat program not found)"
      exit 1
    else
      echo no
      exit 1
    fi
  fi
fi

if [ "$1" = "config" ]; then
  echo 'graph_title TCP Connection States (Port 80)'
  echo 'graph_args -l 0 --base 1000'
  echo 'graph_vlabel connections'
  echo 'graph_category network'
  echo 'graph_period second'
  echo 'graph_info This graph shows the TCP connections states of all the network interfaces combined.'
  for i in ESTABLISHED SYN_SENT SYN_RECV FIN_WAIT1 FIN_WAIT2 TIME_WAIT CLOSE CLOSE_WAIT LAST_ACK CLOSING; do
    echo "$i.label $i"
    echo "$i.type GAUGE"
    echo "$i.max 32999"
    echo "$i.min 0"
  done
  exit 0
fi

netstat -nt | grep ":80" | awk '/^tcp/ { states[$6]++ } END { for (idx in states) print idx ".value " states[idx] }'