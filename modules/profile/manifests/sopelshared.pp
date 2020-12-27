# == Class sopelshared
#
# Installs the shared stuff between both sopel instances.
#
class profile::sopelshared(
){
  file { 'userconfig':
        ensure  => absent,
        path    => '/srv/sopelbots/users.csv',
        source  => 'puppet:///modules/profile/users.csv',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
    file { 'wikiconfig':
        ensure  => absent,
        path    => '/srv/sopelbots/statuswikis.csv',
        source  => 'puppet:///modules/profile/statuswikis.csv',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
    file { 'cloakconfig':
        ensure  => absent,
        path    => '/srv/sopelbots/cloaks.csv',
        source  => 'puppet:///modules/profile/cloaks.csv',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
    file { 'channelmgnt':
        ensure  => file,
        path    => '/srv/sopelbots/channelmgnt.json',
        source  => 'puppet:///modules/profile/channelmgnt.json',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
    file { 'statusv2config':
        ensure  => file,
        path    => '/srv/sopelbots/status.json',
        source  => 'puppet:///modules/profile/status.json',
        mode    => '2755',
        owner   => root,
        group   => root,
    } 
    file { 'phabconfig':
        ensure  => file,
        path    => '/srv/sopelbots/phab.json',
        source  => 'puppet:///modules/profile/phab.json',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
}
