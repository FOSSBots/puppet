#!/bin/bash
cd /etc/puppet/code
sudo git pull
sudo -H puppet apply /etc/puppet/code/manifests/site.pp
