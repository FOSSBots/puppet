#!/bin/bash
cd /etc/puppet/code
sudo git pull
sudo puppet apply /etc/puppet/code/manifests/site.pp
