# automatic-torrent-downloader

### Description
Automatically downloads torrents using links from a file on Dropbox.

I have this set up on a Raspberry Pi at home and add links from my phone to set up torrent downloads from everywhere.

### How to use
Set up a file in your dropbox folder (eg. pi/tor.txt) which you will use to save torrent links in. Make sure to change the path in the shell script. You can edit this file from anywhere.

Running this script will fetch the file from dropbox and add each link into Transmission. This script will also remove any current completed downloads in Transmission.

Set up to run regularly using crontab (eg. every hour).


Requires:
- [Dropbox Uploader](https://github.com/andreafabrizi/Dropbox-Uploader)
- [Transmission](https://transmissionbt.com)
