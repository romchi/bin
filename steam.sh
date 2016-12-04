#! /bin/sh
#
# steam.sh
# Copyright (C) 2016 Roman Bulakh <bulah.roman@gmail.com>
#
# Distributed under terms of the MIT license.
#


export LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' steam
