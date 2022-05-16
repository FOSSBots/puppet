#!/bin/bash
cp /etc/puppet/private/hieradata/common.yaml /backups/<%= lookup('icinga::nodename') %>.yaml
s3cmd -c /backups/.s3cfg /backups/<%=  lookup('icinga::nodename') %>.yaml s3://backup-fossbots
