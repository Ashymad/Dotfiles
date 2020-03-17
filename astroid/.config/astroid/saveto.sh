#!/usr/bin/env bash

FILENAME="$(basename "$1" | sed -n 's/-/&\n/;s/.*\n//p')"
DIRECTORY="$(yad --file --directory)"

if [[ !  -z  $DIRECTORY  ]]; then
	cp "$1" "$DIRECTORY/$FILENAME"
fi
