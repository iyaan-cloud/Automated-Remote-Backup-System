#!/bin/bash
export PATH=/usr/bin:/bin:/usr/sbin:/sbin


date=$(date +%Y-%m-%d)
local_backup_dir=/home/rian/backup/$date.tar.gz
source_dir=/var/log
remote_server=client@192.168.10.2
remote_backup_dir=/home/client/backup

#create directory
mkdir -p /home/rian/backup

#zip the file
/bin/tar -czvf "$local_backup_dir" "$source_dir"

#upload to remote dir
/usr/bin/scp -P 2221 $local_backup_dir $remote_dir:$remote_backup_dir


#check status
if [ $? -eq 0 ]; then

  /bin/echo "[$(date)] Backup Completed successfully and copied." >> /home/rian/backup/log-backup.txt

else

  /bin/echo "[$(date)] FAILED to Backup: There is something worng with the Server." >> /home/rian/backup/log-backup.txt

fi


#delete file expired more than 7 days
find /home/rian/backup -type f -mtime +7 -exec rm -f {} \;
