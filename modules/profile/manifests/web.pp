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
        directory => '/var/flask',
        branch    => 'dev',
        owner     => www-data,
        group     => www-data,
        recurse_submodules => true,
    }
    file { 'post-web-hook':
        ensure  => file,
        path    => '/var/flask/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-flask',
        mode    => '0755',
        owner   => www-data,
        group   => www-data,
    }
    file { 'flaskenv':
        ensure  => directory,
        path    => '/var/flaskenv/',
        mode    => '0755',
        owner   => www-data,
        group   => www-data,
    }
}
