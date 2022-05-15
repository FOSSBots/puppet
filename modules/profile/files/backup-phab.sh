#!/bin/bash
sudo -u www-data /var/phab-deploy/phabricator/bin/phd stop
cp -r /var/phab /backups/phab
tar -czvf /backups/phab.tar.gz /backups/phab
s3cmd -c /backups/.s3cfg sync /backups/phab.tar.gz s3://backups-fossbots
sudo -u www-data /var/phab-deploy/phabricator/bin/phd start
