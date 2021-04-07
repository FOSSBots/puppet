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
        mode    => '770',
        owner   => sopel,
        group   => sopel,
    }
    file { 'statusv2config':
        ensure  => file,
        path    => '/srv/sopelbots/status.json',
        source  => 'puppet:///modules/profile/status.json',
        mode    => '770',
        owner   => sopel,
        group   => sopel,
    }
    file { 'phabconfig':
        ensure  => file,
        path    => '/srv/sopelbots/phab.json',
        source  => 'puppet:///modules/profile/phab.json',
        mode    => '770',
        owner   => sopel,
        group   => sopel,
    }
    systemd::service { 'mirahezebotprod':
        ensure  => present,
        content => systemd_template('mirahezebotprod'),
        restart => true,
    }
    file { 'prod-venv':
        ensure  => directory,
        path    => '/srv/sopelbots/prodvenv/',
        mode    => '770',
        owner   => sopel,
        group   => sopel,
    }
    file { 'prod-require':
        ensure  => file,
        path    => '/srv/sopelbots/prodrequire.txt',
        source  => 'puppet:///modules/profile/prodrequire.txt',
        mode    => '770',
        owner   => sopel,
        group   => sopel,
        notify  => Exec['update prod'],
    }
    exec { 'update prod':
          command     => '/srv/sopelbots/prodvenv/bin/pip3.7 install -U -r /srv/sopelbots/prodrequire.txt',
          cwd         => '/srv/sopelbots/prodvenv',
          refreshonly => true,
          user        => sopel,
          require     => File['prod-venv', 'prod-require']
    }
    git::clone { "MirahezeBots/sopel-CVTFeed":
          ensure    => 'latest',
          directory => "/srv/sopelbots/cvtfeed",
          mode    => '770',
          owner   => sopel,
          group   => sopel,
          branch    => 'main',
    }
}
