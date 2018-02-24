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
notmuch search --output=files tag:deleted and tag:agh and not folder:agh/Trash | xargs -I {} mv -f "{}" $MAILDIR/agh/Trash/cur/

offlineimap
notmuch new

notmuch tag --batch <<EOF
	+o2 tag:new and path:"o2/**"
	+freeos tag:new and path:"freeos/**"
	+agh tag:new and path:"agh/**"
	+deleted tag:new and folder:o2/Trash or folder:freeos/Trash or folder:agh/Trash
	+sent tag:new and folder:o2/Sent or folder:freeos/Sent or folder:"freeos/Sent Items" or folder:agh/Sent
	+spam tag:new and folder:o2/Spam or folder:freeos/Spam or folder:freeos/Junk or folder:agh/Spam
	+inbox tag:new and folder:o2/INBOX or folder:freeos/INBOX or folder:agh/INBOX
	+archive tag:new and folder:o2/INBOX.Archive or folder:freeos/Archive or folder:agh/Archives
	+draft tag:new and folder:o2/Drafts or folder:freeos/Drafts or folder:agh/Drafts
EOF

notmuch tag -new tag:new
