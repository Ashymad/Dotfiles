#!/usr/bin/env bash

en=$(xinput list-props "$1" | grep 'Device Enabled' | tail -c-2)

if [[ en -eq 0 ]]; then
    xinput enable "$1"
else
    xinput disable "$1"
fi
