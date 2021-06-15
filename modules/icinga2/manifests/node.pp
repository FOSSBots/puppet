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
	notify  => Service['icinga2'],
	require => Service['icinga2'],
    }
    
    file { '/usr/lib/nagios/plugins/check_puppet_run':
	    ensure  => present,
	    content => template('icinga2/check_puppet_run'),
        mode    => '0555',
	}
    file { '/usr/lib/nagios/plugins/check_systemd_state':
    	ensure => present,
	source => 'puppet:///modules/systemd/check_systemd_unit_status',
	mode    => '775',
	owner   => root,
	group   => root,
	}
}
