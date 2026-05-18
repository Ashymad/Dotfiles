#!/usr/bin/env bash
exec swaylock $(awww query --json | jq -r '."".[] | ("-i\n" + .name + ":" + .displaying.image)') -s fill
