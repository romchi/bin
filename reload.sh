#! /bin/sh
#
# reload.sh
# Copyright (C) 2016 Roman Bulakh <bulah.roman@gmail.com>
#

for proc in `ps au -u rb | grep  ssh. | grep -v grep | awk '{print $2}'`; do
  kill -9 ${proc};
done

#if [ "$EUID" -ne 0 ]; then
#	export SSH_AUTH_SOCK="${HOME}/.ssh/etoken"
#	killall -9 -q ssh-agent
#	rm -f "${HOME}/.ssh/etoken"
#
#	if [ `lsusb -d 0529:0620 > /dev/null ; echo $?` -eq 0 ]; then
#		if [ `ps -C ssh-agent -o cmd= | grep -ie 'ssh-agent -s -a .*etoken$' > /dev/null ; echo $?` -ne 0 ]; then
#			rm -f "${HOME}/.ssh/etoken"
#			eval `ssh-agent -s -a "${HOME}/.ssh/etoken"` > /dev/null 2>&1
#		fi
#		if [ -z "`ssh-add -l | grep -i libeTPkcs11`" ]; then
#			ssh-add -s /usr/lib/libeTPkcs11.so
#		fi
#	else
#		echo "No eToCken key present!"
#	fi
#fi

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  killall -9 -q ssh-agent
  (umask 066; /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}")
  . "${SSH_ENV}"
  /usr/bin/ssh-add
  /usr/bin/ssh-add -s /usr/lib/libeToken.so
  for i in $(cut -d\; -f1 "${SSH_ENV}" | grep -v '#'); do
    export $i;
  done
}

# Source SSH settings, if applicable
#if [ -f "${SSH_ENV}" ]; then
#  . "${SSH_ENV}" > /dev/null
#  ps -ef | grep ${SSH_AGENT_PID} | grep -v grep | grep ssh-agent$ > /dev/null || {
#    start_agent
#    echo "1"
#    echo $(cut -d\; -f1 "${SSH_ENV}" | grep -v '#') 
#  }
#else
#  start_agent;
#  echo "2"
#  echo $(cut -d\; -f1 "${SSH_ENV}" | grep -v '#')
#fi

start_agent

#ssh-add -l &>/dev/null
#if [ "$?" == 2 ]; then
#  test -r ~/.ssh-agent && \
#    eval "$(<~/.ssh-agent)" >/dev/null
#
#  ssh-add -l &>/dev/null
#  if [ "$?" == 2 ]; then
#    (umask 066; ssh-agent > ~/.ssh-agent)
#    eval "$(<~/.ssh-agent)" >/dev/null
#    ssh-add
#  fi
#fi
