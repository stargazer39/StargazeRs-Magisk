#!/bin/bash

FILE=/data/swap/swapfile
FOLDER=/data/swap
LOG=/data/swap.log

SWAPPINESS=70

echo "-----------------------------------------------" >> "$LOG"
echo "$(date +"%c") Swappiness now is $(cat /proc/sys/vm/swappiness)" >> "$LOG"

if [ -d "$FOLDER" ];
then
	echo "$(date +"%c") Swap folder found" >> "$LOG"
	mkswap "$FILE"
	swapon "$FILE"
	sysctl -w vm.swappiness="$SWAPPINESS"
else
	echo "$(date +"%c") Creating Swap file" >> "$LOG"
	mkdir "$FOLDER"

	if test -f "$FILE";
	then
	    echo "$(date +"%c") $FILE exists." >> "$LOG"
	    mkswap "$FILE"
		swapon "$FILE"
		sysctl -w vm.swappiness="$SWAPPINESS"
	else
		echo "$(date +"%c") $FILE dosen't exist" >> "$LOG"
		dd if=/dev/zero of="$FILE" bs=1024 count=1572864
		mkswap "$FILE"
		swapon "$FILE"
		sysctl -w vm.swappiness="$SWAPPINESS"
	fi
fi

echo "$(date +"%c") Swappiness now is $(cat /proc/sys/vm/swappiness)" >> "$LOG"
echo "$(date +"%c") Bye." >> "$LOG"
echo "-----------------------------------------------" >> "$LOG"
