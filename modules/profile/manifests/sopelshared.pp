# == Class sopelshared
#
# Installs the shared stuff between both sopel instances.
#
class profile::sopelshared(
){
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
    systemd::service { 'mirahezebotprod':
        ensure  => present,
        content => systemd_template('mirahezebotprod'),
        restart => true,
    }
}
