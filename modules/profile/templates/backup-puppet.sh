#!/bin/bash
cp /etc/puppet/private/hieradata/common.yaml /backups/<%= @hostname %>.yaml
s3cmd -c /backups/.s3cfg sync /backups/<%=  @hostname %>.yaml s3://backup-fossbots
