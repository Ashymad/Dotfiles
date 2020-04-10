#!/bin/sh
killall polybar
#env MONITOR=$(polybar -m|head -1|sed -e 's/:.*$//g')
exec polybar -r example
