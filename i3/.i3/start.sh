#!/bin/sh

cpp $HOME/.i3/config.in > $HOME/.i3/config
exec i3
