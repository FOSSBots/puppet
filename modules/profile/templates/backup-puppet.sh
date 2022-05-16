#!/bin/bash
cp /etc/puppet/private/hieradata/common.yaml /backups/<%= $facts[hostname] %>.yaml
s3cmd -c /backups/.s3cfg /backups/<%= $facts[hostname] %>.yaml s3://backup-fossbots
