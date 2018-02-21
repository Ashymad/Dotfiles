#!/bin/sh

FILENAME="$(basename "$1" | sed -n 's/-/&\n/;s/.*\n//p')"
DIRECTORY="$(yad --file-selection --directory)"

cp "$1" "$DIRECTORY/$FILENAME"
