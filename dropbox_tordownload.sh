# Process will download a file from a Dropbox folder containing torrent links.
# Download will start in Transmission, completed downloads will be removed.
#
# Requires:
# - Dropbox Uploader: https://github.com/andreafabrizi/Dropbox-Uploader
# - Transmission: https://transmissionbt.com

TORRENT_FILE='tor.txt'

######################################################
# Download links and start
######################################################

# get file from Dropbox containing links
dropbox_uploader.sh download pi/$TORRENT_FILE ./$TORRENT_FILE

# Declare array to hold links
declare -a links
readarray links < $TORRENT_FILE

if [ ${#links[@]} -gt 0 ]
then

    # Add each link to transmission
    for link in ${links[@]}
    do
        transmission-remote -a $link
    done

    # Empty out torrent links file
    cp /dev/null $TORRENT_FILE

    # Upload dropbox file with empty file
    dropbox_uploader.sh upload ./$TORRENT_FILE pi/$TORRENT_FILE
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


