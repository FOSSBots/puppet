class icinga2::node(){
    $icinga_nodename = lookup('icinga::nodename')
    package { 'icinga2':
        ensure => absent,
    }

    service { 'icinga2':
        ensure  => absent,
        require => Package['icinga2'],
    }

    file { '/etc/icinga2/zones.conf':
        ensure  => absent,
        content => template('icinga2/node-zones.conf'),
        mode    => '775',
        owner   => root,
        group   => root,
	notify  => Service['icinga2'],
    }
    
    file { '/usr/lib/nagios/plugins/check_puppet_run':
	    ensure  => absent,
	    content => template('icinga2/check_puppet_run'),
        mode    => '0555',
	}
    file { '/usr/lib/nagios/plugins/check_systemd_state':
    	ensure => absent,
	source => 'puppet:///modules/systemd/check_systemd_unit_status',
	mode    => '775',
	owner   => root,
	group   => root,
	}
}
