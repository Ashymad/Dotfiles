#!/bin/sh

MON_NMB=2

for i in $(seq 1 $MON_NMB); do
	while ! ddcutil -d $i setvcp 10 $1; do :; done
done
