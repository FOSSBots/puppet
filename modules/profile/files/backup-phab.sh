#!/bin/bash
cp -r /var/phab /backups/phab
tar -czvf /backups/phab.tar.gz /backups/phab
s3cmd -c /backups/.s3cfg sync /backups/phab.tar.gz s3://backups-fossbots
