#!/bin/bash

## calibrating of the dongle 

channel=115
shiftFile="/home/filips/github/autowx2/var/dongleshift.txt"
shiftHistory="/home/dane/nasluch/sat/logs/shifthistory.csv"

#-----------------------------------------------#

mkdir -p `dirname $shiftHistory`
recentShift=`cat $shiftFile`

re='^-?[0-9]+([.][0-9]+)?$'
if ! [[ $recentShift =~ $re ]] ; then
   recentShift=1.5
fi

#kal -s GSM900 -e 61

newShift=`timeout 110s kal -c $channel -g 49.6 -e $recentShift 2> /dev/null | tail -1 | cut -d " " -f 4`
echo $newShift | tee $shiftFile

echo `date +"%Y%m%d_%H:%M:%S"` `date +"%s"`    $newShift >> $shiftHistory
