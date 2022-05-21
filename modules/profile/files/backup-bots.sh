#!/bin/bash
cp /srv/sopelbots/Sygnal.db /backups/sopel/Sygnal.db
rsync -r --exclude 'logs' --exclude 'pids' /srv/sopelbots/prod /backups/sopel
rsync -r --exclude 'logs' --exclude 'pids' /srv/sopelbots/test /backups/sopel
tar -czvf /backups/sopel.tar.gz /backups/sopel
s3cmd -c /backups/.s3cfg sync /backups/sopel.tar.gz s3://backups-fossbots
s3cmd -c /backups/.s3cfg sync /srv/streambot/snitch.db s3://backups-fossbots
