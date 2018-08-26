#!/usr/bin/env bash

# Process will download a file from a Dropbox folder containing torrent links.
# Download will start in Transmission, completed downloads will be removed.
# Set to run regularly using crontab
#
# Requires:
# - Dropbox Uploader: https://github.com/andreafabrizi/Dropbox-Uploader
# - Transmission: https://transmissionbt.com


# path to torrent file on dropbox
TORRENT_FILE='pi/tor.txt'

######################################################
# Search for links to download
######################################################

# get file from Dropbox and save it to a temp file
TEMP_FILE=$(mktemp /tmp/torrents.XXXXXXXXX)
dropbox_uploader.sh download $TORRENT_FILE $TEMP_FILE

# parse each line into an array
declare -a links
readarray links < $TEMP_FILE

num_links=${#links[@]}

if [ $num_links -gt 0 ]
then
    # Add each link to transmission
    for link in ${links[@]}
    do
        transmission-remote -a $link
    done

    # Update dropfile file with empty file
    cp /dev/null $TEMP_FILE
    dropbox_uploader.sh upload $TEMP_FILE $TORRENT_FILE
    rm $TEMP_FILE

else
    echo "No links in file"
fi


######################################################
# Remove completed downloads
######################################################

# Array to hold IDs of completed torrents
declare -a completed_ids
readarray completed_ids < <( transmission-remote -l | grep 100% | awk '{print $1}' )

if [ ${#completed_ids[@]} -gt 0 ]
then

    for id in $completed_ids
    do
        # Remove torrents
        transmission-remote -t $id -r
    done
fi


