#!/bin/bash
export PATH=/usr/bin:/bin:/usr/sbin:/sbin


date=$(date +%Y-%m-%d)
local_backup_dir=/home/rian/backup/$date.tar.gz
source_dir=/var/log
remote_server=client@192.168.10.2
remote_backup_dir=/home/client/backup

#pembuatan folder
mkdir -p /home/rian/backup

#mengubah file jadi tar.gz
/bin/tar -czvf "$local_backup_dir" "$source_dir"


/bin/echo "backup selesai: $date"

#pengiriman ke server backup
/usr/bin/scp -P 2221 $local_backup_dir $remote_dir:$remote_backup_dir


#cek status SCP
if [ $? -eq 0 ]; then

  /bin/echo "[$(date)] backup berhasil di kirim ke server backup." >> /home/rian/backup/log-backup.txt

else

  /bin/echo "[$(date)] GAGAL: Backup TIDAK terkirim ke server backup." >> /home/rian/backup/log-backup.txt

fi


#menghapus file backup yang lebih dari 7 hari
find /home/rian/backup -type f -mtime +7 -exec rm -f {} \;
