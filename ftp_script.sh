#!/bin/sh
HOST='HOST'
USER='USER'
PASSWD='PASSWD'
#
ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
binary
ls Android/data/tech.ula/files/storage/ChangeBox
quit
END_SCRIPT
exit 0
