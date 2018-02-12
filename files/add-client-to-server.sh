#!/bin/bash

backuppc_home=$1
USER=$2
GROUP=$3
CLIENT=$4

KNOWN_HOSTS="${backuppc_home}/.ssh/known_hosts"

test -f $KNOWN_HOSTS || touch $KNOWN_HOSTS
ssh-keyscan -t rsa $CLIENT >> $KNOWN_HOSTS 
chown $USER.$GROUP $KNOWN_HOSTS

exit 0
