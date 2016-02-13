#! /bin/sh
#
# reload.sh
# Copyright (C) 2016 Roman Bulakh <bulah.roman@gmail.com>
#

for proc in `ps au -u rb | grep  ssh. | grep -v grep | awk '{print $2}'`; do
  kill -9 ${proc};
done

