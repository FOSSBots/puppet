class profile::discordirc{
    $discordmh_token = lookup('passwords::discord::mh')
    $discordmh_password = lookup('passwords::irc::mh')
    $discordmhlibera_password = lookup('passwords::irc::mhlibera')
    $discordfh_token = lookup('passwords::discord::fh')
    $discordfh_password = lookup('passwords::irc::fh')
    systemd::service { 'discordircmh':
        ensure  => present,
        content => systemd_template('discordircmh'),
        restart => true,
        require => File['/discord-irc/mhconfig.json'],
    }
    systemd::service { 'discordircfh':
        ensure  => present,
        content => systemd_template('discordircfh'),
        restart => true,
        require => File['/discord-irc/fhconfig.json'],
    }
    systemd::service { 'mhdiscordlibera':
        ensure  => present,
        content => systemd_template('mhdiscordlibera'),
        restart => true,
        require => File['/discord-irc/mhconfiglibera.json'],
    }
    file { '/discord-irc/mhconfig.json':
        ensure  => present,
        content => template('profile/mhconfig.json'),
        notify  => Service['discordircmh'],
        mode    => '770',
        owner   => relays,
        group   => relays,
    }
    
    file { '/discord-irc/mhconfiglibera.json':
        ensure  => present,
        content => template('profile/mhconfiglibera.json'),
        notify  => Service['mhdiscordlibera'],
        mode    => '770',
        owner   => relays,
        group   => relays,
    }
    
    file { '/discord-irc/fhconfig.json':
        ensure  => present,
        content => template('profile/fhconfig.json'),
        notify  => Service['discordircfh'],
        mode    => '770',
        owner   => relays,
        group   => relays,
    }
}
