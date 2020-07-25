# == Class sopelshared
#
# Installs the shared stuff between both sopel instances.
#
class profile::sopelshared(
){
  file { 'userconfig':
        ensure  => file,
        path    => '/srv/sopelbots/users.csv',
        source  => 'puppet:///modules/profile/users.csv',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
    file { 'wikiconfig':
        ensure  => file,
        path    => '/srv/sopelbots/statuswikis.csv',
        source  => 'puppet:///modules/profile/statuswikis.csv',
        mode    => '2755',
        owner   => root,
        group   => root,
    }
    file { 'cloakconfig':
        ensure  => file,
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
}
