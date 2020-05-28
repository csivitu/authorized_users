#!/bin/bash

# Usage: get_keys https://raw.githubusercontent.com/csivitu/authorized_users/master csivit root
# Will try to obtain names of github users from URL/csivit/root, and then obtain github
# keys of each user. Finally, the list of all keys is returned as the authorized keys


HOSTNAME=$2
KEYREPO=$1
USER=$3

authorized=""
while read line; \
do
    authorized="$authorized"$'\n'"$(curl -sf https://github.com/$line.keys)"
done <<< $(curl -sf $KEYREPO/$HOSTNAME/$USER)

echo "$authorized"
