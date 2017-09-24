#!/usr/bin/env bash

MAILDIR="/home/shyman/.mail"

if ! nc -z 127.0.0.1 19455; then
    keepassxc &
    exit
else
    case $(curl -sd '{"RequestType":"test-associate","TriggerUnlock":true}' http://127.0.0.1:19455 | wc -w) in

	0) exit
	   ;;
	*)
	   ;;
    esac
fi

notmuch search --output=files tag:deleted and tag:o2 and not folder:o2/Trash | xargs -I {} mv -f "{}" $MAILDIR/o2/Trash/cur/
notmuch search --output=files tag:deleted and tag:freeos and not folder:freeos/Trash | xargs -I {} mv -f "{}" $MAILDIR/freeos/Trash/cur/

offlineimap
notmuch new

notmuch tag --batch <<EOF
	+o2 tag:new and path:"o2/**"
	+freeos tag:new and path:"freeos/**"
	+deleted tag:new and folder:o2/Trash or folder:freeos/Trash
	+sent tag:new and folder:o2/Sent or folder:freeos/Sent or folder:"freeos/Sent Items"
	+spam tag:new and folder:o2/Spam or folder:freeos/Spam or folder:freeos/Junk
	+inbox tag:new and folder:o2/INBOX or folder:freeos/INBOX
	+archive tag:new and folder:o2/INBOX.Archive or folder:freeos/Archive
	+draft tag:new and folder:o2/Drafts or folder:freeos/Drafts
	-new tag:new
EOF
