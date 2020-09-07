# == Class staticweb
#
# Installs the staticweb repo.
#
class profile::web(
    $install_dir = '/var/www/',
){
 
    git::clone { 'MirahezeBots/bots-web':
        ensure    => 'latest',
        directory => $install_dir,
        branch    => 'master',
        recurse_submodules => true,
    }
}

  file { 'post-dev-hook':
        ensure  => file,
        path    => '/var/www/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-web',
        mode    => '0755',
        owner   => root,
        group   => root,
