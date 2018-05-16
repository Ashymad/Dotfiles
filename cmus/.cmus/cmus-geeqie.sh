#!/usr/bin/env bash
## 'status_display_program' for Cmus. Shows album art in a fixed size window.
## Use your window manager to automatically manipulate the window.
## There are several album art viewers for Cmus but this I believe is the most
## compatible with different setups as it is simpler. No weird hacks.

STATUS=$( cmus-remote -Q | tee /tmp/cmus.status)

FOLDER=$( echo "$STATUS" | grep "file" | sed "s/file //" | rev | cut -d"/" -f2- | rev )

if [[ ${FOLDER:0:3} == "cue" ]]; then
	FOLDER=$(echo "$FOLDER" | sed 's/cue:\/\///g' | rev | cut -d"/" -f2- | rev)
fi

FLIST=$( find "$FOLDER" -type f )

if echo "$FLIST" | grep -i ".jpeg\|.png\|.jpg" &>/dev/null; then
	ART=$( echo "$FLIST" | grep -i "cover.jpg\|cover.png\|front.jpg\|front.png\
	\|folder.jpg\|folder.png" | head -n1 )
	
	if [[ -z "$ART" ]]; then
		ART=$( echo "$FLIST" | grep -i ".png\|.jpg\|.jpeg" | head -n1 )
	fi
	
	geeqie -r File:"$ART"
else
	geeqie -r File:"/home/shyman/.cmus/none.jpg"
fi
