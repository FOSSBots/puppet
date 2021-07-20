class profile::base {	
    include users
    include puppet
    include motd
    include ufw

    package { 'wheel':
        ensure => present,
        name => wheel,
        provider => pip3,
    }

    package { 'pipdeptree':
        ensure => present,
        name => pipdeptree,
        provider => pip3,
    }
    systemd::service { 'ssh':
        ensure  => present,
        require => File['/etc/ssh/sshd_config'],
    }
    file { "/etc/ssh/sshd_config":
        ensure  => present,
        content => 'puppet:///modules/profile/sshd_config',
        notify  => Service['ssh'],
        mode    => '444',
        owner   => root,
        group   => root,
    }
}
