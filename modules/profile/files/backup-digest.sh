#!/bin/bash
s3cmd -c /backups/.s3cfg sync /srv/phabdigest/config.csv s3://backups-fossbots
s3cmd -c /backups/.s3cfg sync /srv/phabdigest/weekly.csv s3://backups-fossbots
