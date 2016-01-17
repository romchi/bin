#!/bin/bash

nodename=`uname -n`

if [[ ${nodename} -eq "lenovo" ]]; then
  # BATDIR is the folder with your battery characteristics
  BATDIR="/sys/class/power_supply/BAT0"
  max=`cat $BATDIR/energy_full`
  current=`cat $BATDIR/energy_now`
  percent=$(( 100 * $current / $max ))

  #percent=$(acpi | grep -o "[0-9]*%")

  if [ $percent -ge 60 ]; then
    color=$color_green;
  elif [ $percent -ge 10 ]; then
    color=$color_yellow;
  else
    color=$color_red;
  fi

else
  $percent="PC";
  $color=$color_grey;
fi

echo $color$percent$color_reset
