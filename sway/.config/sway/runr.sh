#!/bin/sh

exec env DBUS_SESSION_BUS_ADDRESS='unix:path=/tmp/ssh-dbus' firefox
