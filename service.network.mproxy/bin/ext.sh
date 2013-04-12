#!/bin/sh

. $(dirname $0)/../config/mproxy.conf

GROUP="$1"
URL=$(grep "^$GROUP " "$ADDON_CONFIG_DIR/ext.conf" | awk '{print $2}')

if [ ! "$URL" == "" ] ; then
  case "$2" in
    start)
      if [ -e $ADDON_CONFIG_DIR/opts.extra ] ; then
        . $ADDON_CONFIG_DIR/opts.extra
      fi
      if [ ! "$(pidof vlc)" ] ; then
        su -c "cvlc --network-caching=0 --sout-udp-caching=0 \
          "$URL" $OPTS_EXTRA --ts-out "$GROUP:1234"" $USER &
      fi
      ;;
    stop)
      killall -9 vlc
      ;;
  esac
fi
