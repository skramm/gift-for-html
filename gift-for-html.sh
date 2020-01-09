#!/usr/bin/env bash

# name: gift-for-html
# author: S. Kramm
# home: https://github.com/skramm/gift-for-html

# here, you can define the source file extension
SOURCE_EXT=src

# program location
LOCATION=/usr/local/bin


if [ "$1" = "" ]
then
	echo "No input file given, exit !"
	exit
fi

# https://stackoverflow.com/a/965069/193789
filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

if [ "$extension" != "$SOURCE_EXT" ]
then
	echo "Wrong input file, please give me a \".$SOURCE_EXT\" file, exit !"
	exit
fi

echo " -Step 1"
awk -f $LOCATION/process_src2gift_1.awk $1 >/tmp/$filename.tmp1

echo " -Step 2"
awk -f $LOCATION/process_src2gift_2.awk /tmp/$filename.tmp1 >/tmp/$filename.tmp2

echo " -Step 3"
awk -f $LOCATION/process_src2gift_3.awk /tmp/$filename.tmp2 >$filename.gift

#rm /tmp/$filename.tmp

echo " -Done"
