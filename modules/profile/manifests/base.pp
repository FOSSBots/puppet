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
}
