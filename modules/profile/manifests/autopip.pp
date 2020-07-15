# == Class autopip
#
# Installs the staticweb repo.
#
class profile::autopip(
    $install_dir = '/srv/pip',
){
 
    git::clone { 'MirahezeBots/bots-pip-auto':
        ensure    => 'latest',
        directory => $install_dir,
        branch    => 'master',
    }
    cron { 'update-pip':
        ensure  => present,
        command => "/usr/bin/pip3 install -U -r /srv/pip/requirements.txt",
        user    => root,
        minute  => '*/20',
    }
}
