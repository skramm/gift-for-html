#!/usr/bin/env bash

# name: gift-for-html
# author: S. Kramm
# home: https://github.com/skramm/gift-for-html

SOURCE_EXT=src

if [ "$1" = "" ]
then
	echo "No input file given, exit !"
	exit
fi

# https://stackoverflow.com/a/965069/193789
filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

if [ "$extension" != "src" ]
then
	echo "Wrong input file, please give me a \".$SOURCE_EXT\" file, exit !"
	exit
fi

echo " -Step 1"
awk -f process_src2gift_1.awk $1 >/tmp/$filename.tmp

echo " -Step 2"
awk -f process_src2gift_2.awk /tmp/$filename.tmp >$filename.gift

#rm /tmp/$filename.tmp

echo " -Done"
