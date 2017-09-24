#!/bin/sh
if cmus-remote -C status > /tmp/cmus.status; then
	
	TITLE=$(grep 'tag title ' /tmp/cmus.status | tail -c +11)
	ARTIST=$(grep 'tag artist ' /tmp/cmus.status | tail -c +12)
	STATE=$(grep 'status ' /tmp/cmus.status | tail -c +8)
	if [ $STATE = 'playing' ]; then
		printf "\ue058 $ARTIST - $TITLE"
	elif [ $STATE = 'paused' ]; then
		printf "\ue059 $ARTIST - $TITLE"
	else
		printf "\ue057"
	fi
fi