#!/usr/bin/env bash

set -e

if ! pgrep -x keepassxc; then
    echo "KeePassXC is not running!"
    exit
fi

if ! ping -w 1 -W 1 -c 1 posteo.de; then
    echo "No connection to posteo"
    exit
fi

MAILDIR="/home/shyman/.mail"
TAGSTRING=""

moveIt()
{
    s=${1##*/}
    s=${s%%,*}
    mv -f $1 $2/$s
    true
}
export -f moveIt

movemail() {
    notmuch search --output=files tag:$2 and tag:$1 and not folder:$1/$3 | xargs -I{} bash -c "moveIt '{}' $MAILDIR/$1/$3/new/"
}

tag() {
    TAGSTRING="$TAGSTRING$1 tag:new and $2\n"
}

tag_exec() {
    TAGSTRING="$TAGSTRING-new tag:new\n"
    printf "Tagging:\n$TAGSTRING"
    printf "$TAGSTRING" | notmuch tag --batch
}


movemail posteo deleted Trash
movemail posteo archived Archive
movemail posteo note Notes

mbsync posteo
if ! notmuch new | grep "No new mail"; then
    notify-send "New mail
    $(notmuch search tag:new | sed 's/^thread:[0-9a-z]*[ ]*//')"
fi

tag +posteo path:"posteo/**" 
tag +o2 to:czilukim@o2.pl 
tag +deleted folder:posteo/Trash 
tag +sent folder:posteo/Sent 
tag +inbox folder:posteo/Inbox 
tag +draft folder:posteo/Drafts 
tag +note folder:posteo/Notes 
tag_exec

pkill -SIGUSR1 alot
