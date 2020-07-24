# == Class sopelshared
#
# Installs the shared stuff between both sopel instances.
#
class profile::sopelshared(
){
  file { 'userconfig':
        ensure  => file,
        path    => '/srv/sopelbots/users.csv',
        source  => 'puppet:///modules/profile/files/users.csv',
        mode    => 0755,
        owner   => root,
        group   => root,
    }
}
