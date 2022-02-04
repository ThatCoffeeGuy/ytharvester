#!/bin/bash
ts="[`date "+%Y-%m-%d %H:%M:%S"`]"
if [ $# -lt 2 ]; then
    echo "USAGE: harvester <channel or playlist URL> <friendly name> "
    exit 1
fi
sizebefore=`du -skh .`
curdir=$(pwd)
url=$1
name=$2
if [[ -d "$name" ]]
then
    echo "$ts $name folder already exists!"
else
   echo "$ts Creating directory..." && mkdir -p $name && echo "$ts Done!" || echo "$ts ERROR!"
fi
echo "$ts Looking for a youtube-dl upgrade..."
/usr/bin/youtube-dl/youtube-dl -U && echo "$tsExit 0" || echo "$ts Exit not 0, something went wrong."
cd $name
echo "$ts Starting yt harvester for $url channel in $curdir..."
/usr/bin/youtube-dl/youtube-dl $url --download-archive list.txt --ignore-errors --verbose
echo "$ts Completed!"
sizeafter=`du -skh .`
echo "$ts Folder size before: $sizebefore"
echo "$ts Folder size now:    $sizeafter"
