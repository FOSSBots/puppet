# == Class staticweb
#
# Installs the staticweb repo.
#
class profile::web(
){
 
    git::clone { 'MirahezeBots/bots-web':
        ensure    => 'latest',
        directory => '/var/www/',
        branch    => 'master',
        recurse_submodules => true,
    }

  file { 'post-web-hook':
        ensure  => file,
        path    => '/var/www/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-web',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    {
 
    git::clone { 'MirahezeBots/mirahezebots.org':
        ensure    => 'latest',
        directory => $install_dir,
        branch    => 'dev',
        recurse_submodules => true,
    }
}
