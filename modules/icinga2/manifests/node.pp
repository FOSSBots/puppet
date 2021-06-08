class icinga2::node(){
    $icinga_nodename = lookup('icinga::nodename')
    package { 'icinga2':
        ensure => present,
    }

    service { 'icinga':
        ensure  => running,
        require => Package['icinga2'],
    }

    file { '/etc/icinga2/zones.conf':
        ensure  => present,
        content => template('icinga/node-zones.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
}
