#! /bin/sh
#
# heroes3.sh
# Copyright (C) 2016 Roman Bulakh <bulah.roman@gmail.com>
#
# Distributed under terms of the MIT license.
#

# install
# mkdir .winegames
# env WINEPREFIX=~/.winegames/heroes wine winecfg
# env WINEPREFIX=~/.winegames/heroes winetricks directplay

cd '/mnt/ssd/wine/Heroes/drive_c/games/Heroes of Might and Magic III Complete' && env WINEPREFIX=/mnt/ssd/wine/Heroes wine Heroes3.exe
