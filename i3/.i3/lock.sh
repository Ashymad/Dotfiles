#!/usr/bin/env bash
export XSECURELOCK_FONT="Fira Mono"
export XSECURELOCK_SAVER=saver_mpv
export XSECURELOCK_PASSWORD_PROMPT=time_hex
export XSECURELOCK_LIST_VIDEOS_COMMAND="echo ~/.i3/BG.png"
export XSECURELOCK_IMAGE_DURATION_SECONDS=inf
export XSECURELOCK_BLANK_TIMEOUT=30
export XSECURELOCK_AUTH_TIMEOUT=10
xsecurelock&
sleep 0.5
pkill -SIGSTOP picom
wait < <(jobs -p)
pkill -SIGCONT picom
