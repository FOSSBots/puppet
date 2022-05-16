#!/bin/bash
cp /etc/puppet/private/hieradata/common.yaml /backups/<%= $facts[fqdn] %>.yaml
s3cmd -c /backups/.s3cfg /backups/<%= $facts[fqdn] %>.yaml s3://backup-fossbots
