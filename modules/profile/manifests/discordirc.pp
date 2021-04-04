class profile::discordirc{
    $discordmh_token = lookup('passwords::discord::mh')
    $discordmh_password = lookup('passwords::irc::mh')
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
    file { '/discord-irc/mhconfig.json':
        ensure  => present,
        content => template('profile/mhconfig.json'),
        notify  => Service['discordircmh'],
    }
    
    file { '/discord-irc/fhconfig.json':
        ensure  => present,
        content => template('profile/fhconfig.json'),
        notify  => Service['discordircfh'],
    }
}
