#!/bin/sh
TITLE=$(grep 'tag title ' /tmp/cmus.status | tail -c +11)
ARTIST=$(grep 'tag artist ' /tmp/cmus.status | tail -c +12)
STATE=$(grep 'status ' /tmp/cmus.status | tail -c +8)

if [ $STATE = 'playing' ]; then
    echo " $ARTIST - $TITLE"
elif [ $STATE = 'paused' ]; then
    echo " $ARTIST - $TITLE"
else
    echo ""
fi
