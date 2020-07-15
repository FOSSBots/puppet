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
}
