#!/bin/bash

FILE=/data/swap/swapfile
FOLDER=/data/swap

if [ -d "$FOLDER" ];
then
	echo "Swap folder found"
	mkswap "$FILE"
	swapon "$FILE"
else
	echo "Creating Swap file"
	mkdir "$FOLDER"

	if test -f "$FILE";
	then
	    echo "$FILE exists."
	else
		echo "$FILE dosen't exist"
		dd if=/dev/zero of="$FILE" bs=1024 count=1572864
		mkswap "$FILE"
		swapon "$FILE"
	fi
fi