#!/bin/sh

i3-msg "workspace 4; append_layout /home/shyman/.i3/cmus.json"
nohup geeqie -t > /dev/null &
nohup urxvt -e "cmus" > /dev/null &
nohup urxvt -fn "xft:monaco:size=8" -e cava > /dev/null &