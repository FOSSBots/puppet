class profile::streambot{
    $streambot_pass = lookup('passwords::streambot::irc')
    git::clone { 'MirahezeBots/snitchbot':
        ensure    => 'latest',
        directory => '/srv/streambot',
        branch    => 'master',
        owner     => www-data,
        group     => www-data,
        recurse_submodules => true,
    }
    systemd::service { 'streambot':
        ensure  => present,
        content => systemd_template('streambot'),
        restart => true,
    }
    file { '/discord-irc/mhconfig.json':
        ensure  => present,
        content => template('profile/settings.py'),
        notify  => Service['discordircmh'],
        mode    => '770',
        owner   => relays,
        group   => relays,
    }
}
