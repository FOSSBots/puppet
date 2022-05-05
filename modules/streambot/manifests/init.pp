class streambot{
    $streambot_pass = lookup('passwords::streambot::irc')
    git::clone { 'FOSSBots/snitchbot':
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
        content => template('streambot/settings.py'),
        notify  => Service['streambot'],
        require => Git::Clone['FOSSBots/snitchbot'],
        mode    => '770',
        owner   => streambot,
        group   => streambot,
    }
}
