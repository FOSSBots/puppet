# == Class sopelshared
#
# Installs the shared stuff between both sopel instances.
#
class sopel(
){
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
        source  => 'puppet:///modules/sopel/prodrequire.txt',
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
    }
