#!/bin/bash
if [ $# -ne 2 ]; then
    echo "USAGE: harvester <channel or playlist URL> <friendly name>"
    exit 1
fi
ts="[`date "+%Y-%m-%d %H:%M:%S"`]"
if git --version >/dev/null 2&>1; then
    error=`git config --get-color "" "red black bold"`
    warn=`git config --get-color "" "yellow black bold"`
    ok=`git config --get-color "" "green black bold"`
    info=`git config --get-color "" "blue black bold"`
    reset=`git config --get-color "" "reset"`
else
    echo "$ts No git installed, colours won't work. Install with sudo apt-get install git"
    error=""
    ok=""
    info=""
    reset=""
fi
curdir=`pwd`
url=$1
name=$2
ytcookie="ytcookie"
if [[ -d "$name" ]]
then
   echo "$ts ${info}INFO${reset}: $name folder already exists!"
else
   echo "$ts ${info}INFO${reset}: Creating directory..." && mkdir -p $name  >/dev/null 2&>1 && echo "$ts ${info}INFO${reset}: ${ok}Done!${reset}" || echo "$ts ${error}ERROR:${reset} Can't create $name directory."; exit 1
fi
echo "$ts ${info}INFO${reset}: Looking for a yt-dlp upgrade..."
#/usr/local/bin/yt-dlp -U && echo "$ts ${info}INFO${reset}: Exit 0" || echo "$ts ${error}ERROR${reset}} Exit not 0, something went wrong."
cd $name
sizebefore=`du -skh .`
echo "$ts ${info}INFO${reset}: Starting yt harvester for $url channel in $curdir..."
if [[ -f $ytcookie ]]
then
    echo "$ts ${info}INFO${reset}: Found cookie file!"
else
    echo "$ts ${warn}INFO${reset}: Missing cookie file! yt-dlp won't be able to download all videos. Put your cookie file in the target directory: $name "
fi
/usr/local/bin/yt-dlp $url --download-archive list.txt --ignore-errors --verbose --cookies ytcookie --write-subs  --sub-langs "en.*,de,hu" --embed-thumbnail  --embed-metadata  --embed-chapters
echo "$ts ${info}INFO${reset}: Completed!"
sizeafter=`du -skh .`
echo "$ts ${info}INFO${reset}: Folder size before: $sizebefore"
echo "$ts ${info}INFO${reset}: Folder size now:    $sizeafter"
