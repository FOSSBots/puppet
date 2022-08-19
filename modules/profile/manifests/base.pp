class profile::base {	
    include users
    include puppet
    include motd
    include ufw
    $hostname = lookup('icinga::nodename')

    package { 'wheel':
        ensure => present,
        name => wheel,
        provider => pip3,
    }

    package { 'ccze':
        ensure => present,
    }
    
    package { 'needrestart':
        ensure => present,
    }

    package { 'pipdeptree':
        ensure => present,
        name => pipdeptree,
        provider => pip3,
    }
    service { 'ssh':
        ensure  => running,
        require => File['/etc/ssh/sshd_config'],
    }
    file { "/etc/ssh/sshd_config":
        ensure  => present,
        source => 'puppet:///modules/profile/sshd_config',
        notify  => Service['ssh'],
        mode    => '444',
        owner   => root,
        group   => root,
    }
    
    tidy { '/var/lib/puppet/reports':
        age     => '1w',
        recurse => true,
    }
    
    tidy { '/var/log':
        age     => '4w',
        recurse => true,
    }
    
    systemd::timer::job { 'backup-puppet':
        ensure      => present,
        description => 'Backup Puppet',
        command     => "/usr/bin/backup-puppet",
        user        => root,
        interval    => {'start' => 'OnCalendar', 'interval' => 'Tue *-*-* 07:00:00'},
    }
    file { 'puppet-backup-script':
        ensure  => file,
        path    => '/usr/bin/backup-puppet',
        content => template("profile/backup-puppet.sh"),
        mode    => '777',
        owner   => root,
        group   => root,
    }
}
