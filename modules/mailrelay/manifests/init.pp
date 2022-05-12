class mailrelay {
    package { 'postfix':
        ensure => present,
    }

    package { 'exim4':
        ensure => absent,
    }

    file { '/etc/postfix/main.cf':
        ensure  => present,
        owner   => 'postfix',
        group   => 'postfix',
        content => template('mailrelay/main.cf'),
        require => Package['postfix'],
        notify  => Service['postfix'],
    }

    service { 'postfix':
        ensure  => running,
        require => Package['postfix'],
    }

    file { '/etc/mailname':
        ensure  => present,
        content => 'fossbots.org',
    }
}
