#!/usr/bin/env bash
exec swaylock -i "$(awww query --json | jq -r '."".[0].displaying.image')" -s fill
