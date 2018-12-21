#!/usr/bin/env bash

set -e

export MAILDIR="/home/shyman/.mail"

moveIt()
{
    s=${1##*/}
    s=${s%%,*}
    mv -f $1 $2/$s
    true
}
export -f moveIt

#notmuch search --output=files tag:deleted and tag:o2 and not folder:o2/Trash | xargs -I {} mv -f "{}" $MAILDIR/o2/Trash/cur/
#notmuch search --output=files tag:deleted and tag:freeos and not folder:freeos/Trash | xargs -I {} mv -f "{}" $MAILDIR/freeos/Trash/cur/
#notmuch search --output=files tag:deleted and tag:agh and not folder:agh/Trash | xargs -I {} mv -f "{}" $MAILDIR/agh/Trash/cur/
notmuch search --output=files tag:deleted and tag:posteo and not folder:posteo/Trash | xargs -I{} bash -c 'moveIt "{}" $MAILDIR/posteo/Trash/new/'

#    +o2 tag:new and path:"o2/**"
#+freeos tag:new and path:"freeos/**"
#    +agh tag:new and path:"agh/**"
#	+deleted tag:new and folder:o2/Trash or folder:freeos/Trash or folder:agh/Trash
#	+sent tag:new and folder:o2/Sent or folder:freeos/Sent or folder:"freeos/Sent Items" or folder:agh/Sent
#	+spam tag:new and folder:o2/Spam or folder:freeos/Spam or folder:freeos/Junk or folder:agh/Spam
#	+inbox tag:new and folder:o2/INBOX or folder:freeos/INBOX or folder:agh/INBOX
#	+archive tag:new and folder:o2/INBOX.Archive or folder:freeos/Archive or folder:agh/Archives
#	+draft tag:new and folder:o2/Drafts or folder:freeos/Drafts or folder:agh/Drafts

mbsync posteo
notmuch new

notmuch tag --batch <<EOF
        +posteo tag:new and path:"posteo/**"
	+deleted tag:new and folder:posteo/Trash
	+sent tag:new and folder:posteo/Sent
	+inbox tag:new and folder:posteo/Inbox
	+draft tag:new and folder:posteo/Drafts
	+note tag:new and folder:posteo/Notes
	+migration tag:new and folder:"posteo/Migration_*"
EOF

notmuch tag -new tag:new
