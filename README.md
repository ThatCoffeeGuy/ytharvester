# ytharvest

## Easy youtube-channel and playlist ripper using simple bash and yt-dl.

### requirements: 

[https://github.com/yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp) installed in /usr/local/bin/yt-dlp

[```https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid```](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid) for ytcookie extraction in client browser

```ffmpeg```


### Example usage:

```./harvest.sh https://www.youtube.com/c/shiey Shiey```

### This will:
1.) Create a folder called Shiey

2.) Create a list.txt in target folder, ensuring there are no duplicates downloaded

3.) Download videos in highest avilable quality, with the following flags:

```--download-archive list.txt --ignore-errors --verbose --cookies ytcookie --write-subs  --sub-langs "en.*,de,hu" --embed-thumbnail  --embed-metadata  --embed-chapters```

4.) Compare directory sizes once finished
