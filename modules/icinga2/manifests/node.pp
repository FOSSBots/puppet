class icinga2::node(){
    $icinga_nodename = lookup('icinga::nodename')
    package { 'icinga2':
        ensure => present,
    }

    service { 'icinga2':
        ensure  => running,
        require => Package['icinga2'],
    }

    file { '/etc/icinga2/zones.conf':
        ensure  => present,
        content => template('icinga2/node-zones.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
    }
    
    file { '/usr/lib/nagios/plugins/check_puppet_run':
	    ensure  => present,
	    content => template('icinga2/check_puppet_run'),
        mode    => '0555',
	}
}
