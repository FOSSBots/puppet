# == Class staticweb
#
# Installs the staticweb repo.
#
class profile::web(
){
 
    git::clone { 'MirahezeBots/bots-web':
        ensure    => absent,
        directory => '/var/www/',
        branch    => 'master',
        recurse_submodules => true,
    }

  file { 'post-web-hook':
        ensure  => absent,
        path    => '/var/www/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-web',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
 
    git::clone { 'MirahezeBots/mirahezebots.org':
        ensure    => 'latest',
        directory => '/var/flask',
        branch    => 'dev',
        owner     => www-data,
        group     => www-data,
        recurse_submodules => true,
    }
    file { 'post-flask-hook':
        ensure  => file,
        path    => '/var/flask/.git/hooks/post-merge',
        source  => 'puppet:///modules/profile/post-merge-flask',
        mode    => '0755',
        owner   => www-data,
        group   => www-data,
    }
    file { 'flask-config':
        ensure  => file,
        path    => '/var/flask/config.json',
        source  => 'puppet:///modules/profile/webconfig.json',
        mode    => '0755',
        owner   => www-data,
        group   => www-data,
    }
    file { 'flask-wsgi':
        ensure  => file,
        path    => '/var/flask/mhbots.wsgi',
        source  => 'puppet:///modules/profile/mhbots.wsgi',
        mode    => '0755',
        owner   => www-data,
        group   => www-data,
    }
}
