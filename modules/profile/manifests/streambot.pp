class profile::streambot{
    $streambot_pass = lookup('passwords::streambot::irc')
    git::clone { 'MirahezeBots/snitchbot':
        ensure    => 'latest',
        directory => '/srv/streambot',
        branch    => 'master',
        owner     => streambot,
        group     => streambot,
        recurse_submodules => true,
    }
    systemd::service { 'streambot':
        ensure  => present,
        content => systemd_template('streambot'),
        restart => true,
    }
    file { '/srv/streambot/settings.py':
        ensure  => present,
        content => template('profile/settings.py'),
        notify  => Service['streambot'],
        mode    => '770',
        owner   => streambot,
        group   => streambot,
    }
}
