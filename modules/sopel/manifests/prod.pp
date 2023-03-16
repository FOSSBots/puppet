# == Class sopelprod
#
# Installs the prod stuff for sopel.
#
class sopel::prod(
){
  $ensure = lookup('sopel::prod::timer')
  systemd::service { 'mirahezebotprodlibera':
        ensure  => $ensure,
        content => systemd_template('mirahezebotprodlibera'),
        restart => true,
    }
  file { 'prod-venv':
        ensure  => $ensure,
        path    => '/srv/sopelbots/prodvenv/',
        mode    => '770',
        owner   => sopel,
        group   => sopel,
    }
    file { 'prod-require':
        ensure  => $ensure,
        path    => '/srv/sopelbots/prodrequire.txt',
        source  => 'puppet:///modules/sopel/prodrequire.txt',
        mode    => '770',
        owner   => sopel,
        group   => sopel,
        notify  => Exec['update prod'],
    }
    exec { 'update prod':
          command     => '/srv/sopelbots/prodvenv/bin/pip3.9 install -U -r /srv/sopelbots/prodrequire.txt',
          cwd         => '/srv/sopelbots/prodvenv',
          refreshonly => true,
          user        => sopel,
          require     => File['prod-venv', 'prod-require']
    }
    }
