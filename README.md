# automatic-torrent-downloader
Automatically downloads torrents using links from a file on Dropbox


Set up a file in your dropbox folder (eg. pi/tor.txt) which you will use to save torrent links in. Make sure to change the path in the shell script. 

Running this script will fetch the file from dropbox and add each link into Transmission.

This script will also remove any current completed downloads in Transmission.

Set up to run regularly using crontab. I have mine set to run every half hour.


Requires:
- [Dropbox Uploader](https://github.com/andreafabrizi/Dropbox-Uploader)
- [Transmission](https://transmissionbt.com)
