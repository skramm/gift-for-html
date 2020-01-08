#!/usr/bin/env bash

# name: gift-for-html
# author: S. Kramm
# home: https://github.com/skramm/gift-for-html

SOURCE_EXT=src

if [ "$1" = "" ]
then
	echo "no input file given, exit !"
	exit
fi



echo " -Step 1"
awk -f process_src2gift_1.awk $1.$SOURCE_EXT >/tmp/$1.tmp

echo " -Step 2"
awk -f process_src2gift_2.awk /tmp/$1.tmp >$1.gift

#rm /tmp/$1.tmp
