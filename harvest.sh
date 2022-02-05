#!/bin/bash
ts="[`date "+%Y-%m-%d %H:%M:%S"`]"
if [ $# -lt 2 ]; then
    echo "USAGE: harvester <channel or playlist URL> <friendly name>"
    exit 1
fi
curdir=`pwd`
url=$1
name=$2
if [[ -d "$name" ]]
then
    echo "$ts $name folder already exists!"
else
   echo "$ts Creating directory..." && mkdir -p $name && echo "$ts Done!" || echo "$ts ERROR!"
fi
echo "$ts Looking for a youtube-dl upgrade..."
/usr/local/bin/yt-dlp -U && echo "$ts Exit 0" || echo "$ts Exit not 0, something went wrong."
cd $name
sizebefore=`du -skh .`
echo "$ts Starting yt harvester for $url channel in $curdir..."
/usr/local/bin/yt-dlp $url --download-archive list.txt --ignore-errors --verbose --cookies ytcookie
echo "$ts Completed!"
sizeafter=`du -skh .`
echo "$ts Folder size before: $sizebefore"
echo "$ts Folder size now:    $sizeafter"