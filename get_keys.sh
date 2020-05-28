#!/bin/bash

# Usage: get_keys https://raw.githubusercontent.com/csivitu/authorized_users/master root
# Will try to obtain names of github users from URL/<hostname>/root, and then obtain github
# keys of each user. Finally, the list of all keys is returned as the authorized keys


HOSTNAME=$(hostname)
KEYREPO=$1
USER=$2


curl -sf $REPO/$USER 

#WIP
