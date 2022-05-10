#!/bin/bash
mysqldump --all-databases > /backups/db.sql
tar -czvf /backups/db.tar.gz /backups/db.sql
s3cmd -c /backups/.s3cfg sync /backups/db.tar.gz s3://backups-fossbots
