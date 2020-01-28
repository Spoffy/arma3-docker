#!/bin/bash

if [[ -z "$STEAM_USERNAME" || -z "$STEAM_PASSWORD" ]]
then
	echo "Username or password missing"
	exit 1
fi

OPTS=""

if [ $VALIDATE == 1 ]; then
	OPTS="validate"
fi

if [[ -z "$STEAM_GUARD_CODE" ]]
then
	STEAM_GUARD=""
else
	STEAM_GUARD="+set_steam_guard_code $STEAM_GUARD_CODE"
fi

echo $STEAM_GUARD

/root/steamcmd.sh $STEAM_GUARD +login $STEAM_USERNAME $STEAM_PASSWORD +force_install_dir /arma3 +app_update 233780 $OPTS +quit || exit 1

#workaround for server bug
rm /arma3/steamclient.so
ln -s /root/linux32/steamclient.so /arma3/steamclient.so

unset OPTS
unset STEAM_USERNAME
unset STEAM_PASSWORD
unset STEAM_GUARD
unset STEAM_GUARD_CODE
