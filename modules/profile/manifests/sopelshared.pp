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
    file { 'prod-venv':
        ensure  => directory,
        path    => '/srv/sopelbots/prodvenv/',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    file { 'prod-require':
        ensure  => file,
        path    => '/srv/sopelbots/prodrequire.txt',
        source  => 'puppet:///modules/profile/prodrequire.txt',
        mode    => '2755',
        owner   => root,
        group   => root,
        notify  => Exec['update prod'],
    }
    exec { 'update prod':
          command     => '/usr/bin/sudo /srv/sopelbots/prodvenv/bin/pip3.7 install -U -r /srv/sopelbots/prodrequire.txt',
          cwd         => '/srv/sopelbots/prodvenv',
          refreshonly => true,
          require     => File['prod-venv', 'prod-require']
    }
}
