class profile::discordirc{
    $discordmh_token = lookup('passwords::discord::mh')
    $discordmh_password = lookup('passwords::irc::mh')
    $discordmhlibera_password = lookup('passwords::irc::mhlibera')
    $discordfh_token = lookup('passwords::discord::fh')
    $discordfh_password = lookup('passwords::irc::fh')
    $discordfhlibera_password = lookup('passwords::irc::fhlibera')
    systemd::service { 'discordircmh':
        ensure  => absent,
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
        require => File['/discord-irc/mhliberaconfig.json'],
    }
    systemd::service { 'fhdiscordlibera':
        ensure  => present,
        content => systemd_template('fhdiscordlibera'),
        restart => true,
        require => File['/discord-irc/fhliberaconfig.json'],
    }
    file { '/discord-irc/mhconfig.json':
        ensure  => present,
        content => template('profile/mhconfig.json'),
        notify  => Service['discordircmh'],
        mode    => '770',
        owner   => relays,
        group   => relays,
    }
    
    file { '/discord-irc/mhliberaconfig.json':
        ensure  => present,
        content => template('profile/mhliberaconfig.json'),
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
    file { '/discord-irc/fhliberaconfig.json':
        ensure  => present,
        content => template('profile/fhliberaconfig.json'),
        notify  => Service['fhdiscordlibera'],
        mode    => '770',
        owner   => relays,
        group   => relays,
    }
}
